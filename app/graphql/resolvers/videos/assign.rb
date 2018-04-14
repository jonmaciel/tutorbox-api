module Resolvers
  module Videos
    module Assign
      class << self
        def call(_, input, context)
          current_user = context[:current_user]
          current_user.authorize!(:assign, Video)

          user_to_assign = User.find(input[:userId])

          if (current_user.end_user? && user_to_assign.tutormaker?) || current_user.video_producer?
            raise Exceptions::PermissionDeniedError.new
          end

          video_to_be_assigned = Video.find(input[:videoId])

          video_to_be_assigned.users << user_to_assign

          { success: video_to_be_assigned.save! }
        end
      end
    end
  end
end
