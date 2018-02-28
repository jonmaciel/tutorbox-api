module Resolvers
  module Videos
    module Update
      class << self
        def call(_, input, context)
          video_to_update = Video.find(input[:id])

          input[:videoAttributes].to_h.each do |attribute, value|
            video_to_update.send("#{attribute}=", value)
          end

          raise 'Not authorized' unless context[:current_user].can?(:update, video_to_update)

          video_to_update.save!

          { video: video_to_update }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
