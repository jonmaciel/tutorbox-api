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
      storage = Fog::Storage.new(
        provider: 'AWS',
        aws_access_key_id: 'AKIAIYZDDECTXTMSGEDA',
        aws_secret_access_key: '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',
        region:'us-east-2'
      )

      storage.put_object_url('tutorbox-files', "#{SecureRandom.hex(8)}", 15.minutes.from_now.to_time.to_i)
    end
  end
end
