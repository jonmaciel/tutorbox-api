module Resolvers
  module Videos
    module Unassign
      class << self
        def call(_, input, context)
          context[:current_user].authorize!(:assign, Video)

          user_to_be_unassigned = User.find(input[:userId])
          video_to_unassign = Video.find(input[:videoId])

          user_to_be_unassigned.videos.delete(video_to_unassign)

          { success: user_to_be_unassigned.save! }
        end
      end
    end
  end
end
