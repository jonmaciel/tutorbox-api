Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :organization, Types::OrganizationType do
    description 'Get single organization'
    argument :id, !types.ID, 'Organization ID'
    resolve ->(_, input, context) do
      organization = Organization.find(input[:id])
      context[:current_user].authorize!(:read, organization)
      organization
    end
  end

  field :organizations, types[Types::OrganizationType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      context[:current_user].authorize!(:read_collection, Organization)
      Organization.all
    end
  end

  field :videos, types[Types::VideoType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      current_user = context[:current_user]
      current_user.authorize!(:read_collection, Video)

      return Video.all if current_user.admin?
      return Video.where(aasm_state: :script_creation) if current_user.script_writer?
      []
    end
  end

  field :video, Types::VideoType do
    argument :id, !types.ID, 'Video ID'
    description 'Get organizations'
    resolve ->(_, input, context) do
      video = Video.find(input[:id])
      context[:current_user].authorize!(:read, video)
      video
    end
  end


  field :attachments, types[Types::AttachmentType] do
    description 'Get attachments'
    argument :videoId, !types.ID, 'Video ID'
    resolve ->(_, input, context) do
      video = Video.find(input[:videoId])

      context[:current_user].authorize!(:video_attachments, video)

      video.attachments
    end
  end

  field :tutormakers, types[Types::UserType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      context[:current_user].authorize!(:read_tutormakers, User)
      User.tutormakers
    end
  end

  field :users, types[Types::UserType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      context[:current_user].authorize!(:read_collection, User)
      User.all
    end
  end

  field :user, Types::UserType do
    argument :id, !types.ID, 'Video ID'
    description 'Get organizations'
    resolve ->(_, input, context) do
      user = User.find(input[:id])
      context[:current_user].authorize!(:read, user)
      user
    end
  end

  field :assignedVideos, types[Types::VideoType] do
    description 'Get organizations'
    argument :userId, types.ID, 'User ID'

    resolve ->(_, input, context) do
      input[:userId] && !context[:current_user].authorize!(:read_collection, Video)

      user = input[:userId] ? User.find(input[:userId]) : context[:current_user]
      user.videos
    end
  end

  field :s3SignedUrl, types.String do
    resolve ->(_, input, context) do
      require 'aws-sdk-s3'
      options = {
        region: 'us-east-1',
        credentials: Aws::Credentials.new('AKIAIDV3FJF3WMG5GHHA',
                                          'q2tiO8ZKhbr/FvIkZYj5Ozl+9qhPl9DqLc3rAu6Z')
      }
      Aws.config.update(options)

      s3 = Aws::S3::Resource.new.bucket('tutorboxfiles')
      object = s3.object('qualquercoisa')
      object.presigned_url(
        :put,
        expires_in: 5.minutes.to_i,
        acl: 'public-read'
      )
    end
  end
end
