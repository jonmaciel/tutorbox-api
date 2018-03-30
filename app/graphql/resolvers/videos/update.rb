module Resolvers
  module Videos
    module Update
      class << self
        def call(_, input, context)
          video_to_update = Video.find(input[:id])

          input[:videoAttributes].to_h.each do |attribute, value|
            video_to_update.send("#{attribute}=", value)
          end

          context[:current_user].authorize!(:update, video_to_update)

          video_to_update.save!

          { video: video_to_update }
        end
      end
    end
  end
end
