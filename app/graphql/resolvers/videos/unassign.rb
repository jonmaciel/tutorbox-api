module Resolvers
  module Videos
    module Unassign
      class << self
        def call(_, input, context)
          current_user = context[:current_user]
          current_user.authorize!(:assign, Video)

          user_to_unassign = User.find(input[:userId])

          if (current_user.end_user? && user_to_unassign.tutormaker?) || current_user.video_producer?
            raise Exceptions::PermissionDeniedError.new
          end

          video_to_be_unassigned = Video.find(input[:videoId])

          video_to_be_unassigned.users.delete(user_to_unassign)

          { success: video_to_be_unassigned.save! }
        end
      end
    end
  end
end
