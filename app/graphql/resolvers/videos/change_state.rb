module Resolvers
  module Videos
    module ChangeState
      class << self
        def call(_, input, context)
          video_to_change = Video.find(input[:id])

          event = input[:event].underscore.to_sym

          raise 'Not permitted event' unless video_to_change.permited_events.include?(event)
          raise 'Not authorized' unless context[:current_user].can?(event, video_to_change)

          video_to_change.send(event)

          { success: true }
        rescue Exception => e
          GraphQL::ExecutionError.new(e.to_s)
        end
      end
    end
  end
end
