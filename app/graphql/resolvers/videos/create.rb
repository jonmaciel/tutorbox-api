module Resolvers
  module Videos
    module Create
      class << self
        def call(_, input, context)
          new_video = Video.new(input[:newVideoAttributes].to_h)
          new_video.created_by = context[:current_user]

          raise 'Not authorized' unless context[:current_user].can?(:create, new_video)

          new_video.save!

          { video: new_video }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
