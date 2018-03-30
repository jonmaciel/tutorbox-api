module Resolvers
  module Videos
    module Assign
      class << self
        def call(_, input, context)
          context[:current_user].authorize!(:assign, Video)

          user_to_be_assigned = User.find(input[:userId])
          video_to_assign = Video.find(input[:videoId])

          user_to_be_assigned.videos << video_to_assign
          user_to_be_assigned.save!

          { success: true }
        end
      end
    end
  end
end
