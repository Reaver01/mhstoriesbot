module Bot
  module Commands
    # Command Name
    module Register
      extend Discordrb::Commands::CommandContainer
      command(
        [:register, :reg],
        description: 'Registers a new hunter',
        usage: 'register'
      ) do |event|
        if Database::Player.player(event.user.id)
          event.respond 'You are already a registered hunter!'
        else
          Database::Player.new_player(event.user.id)
          event.respond 'You are now a registered hunter! Here is a recently hatched Velocidrome as a gift for registering!'
        end
      end
    end
  end
end
