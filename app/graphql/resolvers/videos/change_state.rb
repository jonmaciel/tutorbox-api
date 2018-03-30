module Resolvers
  module Videos
    module ChangeState
      class << self
        def call(_, input, context)
          video_to_change = Video.find(input[:id])

          event = input[:event].underscore.to_sym

          video_to_change.authorize_event!(event)
          context[:current_user].authorize!(event, video_to_change)

          video_to_change.send(event)

          { success: true }
        end
      end
    end
  end
end
