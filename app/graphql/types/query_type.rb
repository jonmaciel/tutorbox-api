Types::QueryType = GraphQL::ObjectType.define do
  name 'Query'

  field :organization, Types::OrganizationType do
    description 'Get single organization'
    argument :id, !types.ID, 'Organization ID'
    resolve ->(_, input, context) do
      begin
        organization = Organization.find(input[:id])
        raise 'Not authorized' unless context[:current_user].can?(:read, organization)
        organization
      rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
      end
    end
  end

  field :organizations, types[Types::OrganizationType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      begin
        raise 'Not authorized' unless context[:current_user].can?(:read_collection, Organization)
        Organization.all
      rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
      end
    end
  end

  field :videos, types[Types::VideoType] do
    description 'Get organizations'
    resolve ->(_, input, context) do
      begin
        raise 'Not authorized' unless context[:current_user].can?(:read_collection, Video)
        Video.all
      rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
      end
    end
  end

  field :video, Types::VideoType do
    argument :id, !types.ID, 'Video ID'
    description 'Get organizations'
    resolve ->(_, input, context) do
      begin
        video = Video.find(input[:id])
        raise 'Not authorized' unless context[:current_user].can?(:read, video)
        video
      rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
      end
    end
  end

  field :assignedVideos, types[Types::VideoType] do
    description 'Get organizations'
    argument :userId, types.ID, 'User ID'

    resolve ->(_, input, context) do
      begin
        raise 'Not authorized' if input[:userId] && !context[:current_user].can?(:read_collection, Video)
        user = input[:userId] ? User.find(input[:userId]) : context[:current_user]
        user.videos
      rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
      end
    end
  end
end
