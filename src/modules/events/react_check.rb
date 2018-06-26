module Bot
  module Events
    # Reaction event
    module Reactions
      extend Discordrb::EventContainer
      reaction_add(emoji: "\u2705") do |event|
        # Check if the message is from the bot
        next unless event.message.from_bot?

        if Database::Room.creation_message(event.message.id).nil?
          # do nothing
        else
          dbmessage_id = Database::Room.creation_message(event.message.id).message_id
          dbchannel_id = Database::Room.creation_message(event.message.id).channel_id
          dbspawner_id = Database::Room.creation_message(event.message.id).spawner_id
          dbclaimer_id = Database::Room.creation_message(event.message.id).claimer_id
          claimed = Database::Room.creation_message(event.message.id).claimed
          rejected = Database::Room.creation_message(event.message.id).rejected
          deleted = Database::Room.creation_message(event.message.id).deleted
        
          claimer = Discordrb::Permissions.new
          claimer.can_read_messages = true
        
          spectator = Discordrb::Permissions.new
          spectator.can_read_messages = true
        
          deny = Discordrb::Permissions.new
          deny.can_send_messages = true
        
          if deleted
            # message that it's deleted or something
          else
            if event.user.id == dbspawner_id and claimed == false
              BOT.channel(dbchannel_id).send_message("#{event.user.mention} has claimed the nest!")
              Database::Room.creation_message(event.message.id).claim(event.user.id)
              BOT.channel(dbchannel_id).define_overwrite(event.user, claimer, 0)
            else
              if claimed and event.user.id != dbclaimer_id
                BOT.channel(dbchannel_id).send_message("#{event.user.mention} has entered the nest as a spectator!")
                BOT.channel(dbchannel_id).define_overwrite(event.user, spectator, deny)
              else
                if rejected
                  BOT.channel(dbchannel_id).send_message("#{event.user.mention} has claimed the nest!")
                  BOT.channel(dbchannel_id).define_overwrite(event.user, claimer, 0)
                else
                  BOT.channel(dbchannel_id).send_message("#{event.user.mention} has entered the nest as a spectator!")
                  BOT.channel(dbchannel_id).define_overwrite(event.user, spectator, deny)
                end
              end
            end
          end
        end
      end
    end
  end
end
