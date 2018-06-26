module Bot
  module Commands
    # Command Name
    module Nest
      extend Discordrb::Commands::CommandContainer
      command(
        :nest,
        description: 'Makes a nest',
        usage: 'nest'
      ) do |event|
        nest_category = event.server.channels.find { |channel| channel.name == "Monster Nests" }
        nest_category = event.server.create_channel("Monster Nests", type = 4) if nest_category.nil?
        
        allow = Discordrb::Permissions.new
        allow.can_read_messages = true
        
        
        deny = Discordrb::Permissions.new
        deny.can_read_messages = true
        
        role = event.server.roles.find { |r| r.name == 'Navirou' }
        
        bot_perms = Discordrb::Overwrite.new(role, allow: allow, deny: 0)
        everyone_perms = Discordrb::Overwrite.new(event.server.everyone_role, allow: 0, deny: deny)
        
        nest = event.server.create_channel("Nest#{rand(10000..99999)}", parent: nest_category.id, permission_overwrites: [everyone_perms, bot_perms])
        
        sent = event.channel.send_message("Nest created")
        Database::Room.create_channel(nest.id).add_message(sent.id)
        Database::Room.create_channel(nest.id).add_spawner(event.user.id)

        sent.create_reaction("\u2705")
        sent.create_reaction("\u274e")
        
        SCHEDULER.in '1m' do
          unless Database::Room.creation_message(sent.id).claimed
            begin
              BOT.channel(Database::Room.creation_message(sent.id).channel_id).send_message("#{event.user.name} has not claimed the nest in time! A spectator can now freely claim the room!")
              Database::Room.creation_message(sent.id).reject
            rescue => s
              puts s
            end
          end
        end
        
        SCHEDULER.in '5m' do
          unless Database::Room.creation_message(sent.id).claimed
            begin
              BOT.channel(nest.id).delete
            rescue => s
              puts s
            end
          end
          begin
            sent.delete
          rescue => s
            puts s
          end
        end
        nil
      end
    end
  end
end
