module Resolvers
  module Videos
    module Assign
      class << self
        def call(_, input, context)
          raise 'Not authorized' unless context[:current_user].can?(:assign, Video)

          user_to_be_assigned = User.find(input[:userId])
          video_to_assign = Video.find(input[:videoId])

          user_to_be_assigned.videos << video_to_assign
          user_to_be_assigned.save!

          { success: true }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
