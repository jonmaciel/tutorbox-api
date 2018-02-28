module Resolvers
  module Videos
    module Destroy
      class << self
        def call(_, input, context)
          video_to_delete = Video.find(input[:id])
          raise 'Not authorized' unless context[:current_user].can?(:destroy, video_to_delete)

          { success: video_to_delete.destroy! }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
