module Bot
  module Events
    # Ready event
    module Ready
      extend Discordrb::EventContainer
      ready do |_event|
        # Set game text
        BOT.game = 'developing'

        # Tell the console BOT is ready
        puts "Invite Link: #{BOT.invite_url(permission_bits: 268_528_720)}"
        puts 'BOT Ready!'
      end
    end
  end
end
