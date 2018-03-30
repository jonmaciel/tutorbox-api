module Resolvers
  module Videos
    module Destroy
      class << self
        def call(_, input, context)
          video_to_delete = Video.find(input[:id])
          context[:current_user].authorize!(:destroy, video_to_delete)

          { success: video_to_delete.destroy! }
        end
      end
    end
  end
end
