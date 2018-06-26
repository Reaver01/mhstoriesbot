module Bot
  module Events
    # Ready event
    module Message
      extend Discordrb::EventContainer
      message do |event|
        if event.channel.default?
          # Do the thing
        end
      end
    end
  end
end
