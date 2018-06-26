module Bot
  module Commands
    # Command Name
    module Ping
      extend Discordrb::Commands::CommandContainer
      command(
        :ping,
        description: 'Pings the bot',
        usage: 'ping'
      ) do |event|
        sent = event.channel.send_message("Pong")
      end
    end
  end
end
