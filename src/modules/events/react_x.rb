module Bot
  module Events
    # Reaction event
    module Reactions
      extend Discordrb::EventContainer
      reaction_add(emoji: "\u274e") do |event|
        # Check if the message is from the bot
        next unless event.message.from_bot?
        
        if Database::Room.creation_message(event.message.id).nil?
          # do nothing
        else
          if deleted
          # Do nothing I guess
          else
            if event.user.id == Database::Room.creation_message(event.message.id).spawner_id
              BOT.channel(Database::Room.creation_message(event.message.id).channel_id).send_message("#{event.user.name} has rejected the nest! A spectator can now freely claim the room!")
              Database::Room.creation_message(event.message.id).reject
            end
          end
        end
      end
    end
  end
end
