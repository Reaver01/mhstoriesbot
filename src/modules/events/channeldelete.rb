module Bot
  module Events
    # Ready event
    module ChannelDeleteEvent
      extend Discordrb::EventContainer
      channel_delete do |event|
        if Database::Room.channel_lookup(event.id)
          Database::Room.channel_lookup(event.id).delete_channel
        end
      end
    end
  end
end
