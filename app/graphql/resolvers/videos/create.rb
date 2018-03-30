module Resolvers
  module Videos
    module Create
      class << self
        def call(_, input, context)
          new_video = Video.new(input[:newVideoAttributes].to_h)
          new_video.created_by = context[:current_user]

          context[:current_user].authorize!(:create, new_video)

          new_video.save!

          { video: new_video }
        end
      end
    end
  end
end
