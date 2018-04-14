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
      # current_user.authorize!(:read_collection, Video)
      return Video.where(system: current_user.organization.systems) if current_user.end_user?
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

  field :selectMembers, types[Types::UserType] do
    argument :organizationId, !types.ID, 'Video ID'
    description 'Get organizations'
    resolve ->(_, input, context) do
      organization = Organization.find(input[:organizationId])

      context[:current_user].authorize!(:show, organization)

      return users(system: current_user.organization.systems) if current_user.end_user?
      return users.or(User.where(organization: nil)) if current_user.admin? || current_user.script_writer?
      []
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

  field :s3SignedUrl, Types::S3Type do
    argument :fileType, types.String, 'User ID'
    argument :videoId, !types.ID, 'User ID'
    resolve ->(_, input, context) do
      return unless input[:fileType]

      require 'aws-sdk-s3'

      new_name = "video_attachments/#{input[:videoId]}/#{SecureRandom.hex}.#{input[:fileType].split('/').last}"

      Aws.config.update({
        region: 'us-east-2',
        credentials: Aws::Credentials.new('AKIAIDV3FJF3WMG5GHHA', 'q2tiO8ZKhbr/FvIkZYj5Ozl+9qhPl9DqLc3rAu6Z')
      })

      s3 = Aws::S3::Resource.new.bucket('tutorbox-files')

      object = s3.object(new_name)

      {
        file_name: new_name,
        signed_url: object.presigned_url(
                    :put,
                    expires_in: 5.minutes.to_i,
                    acl: 'public-read'
                  )
      }
    end
  end
end
