module Resolvers
  module Videos
    module Unassign
      class << self
        def call(_, input, context)
          raise 'Not authorized' unless context[:current_user].can?(:assign, Video)

          user_to_be_unassigned = User.find(input[:userId])
          video_to_unassign = Video.find(input[:videoId])

          user_to_be_unassigned.videos.delete(video_to_unassign)

          { success: user_to_be_unassigned.save! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
