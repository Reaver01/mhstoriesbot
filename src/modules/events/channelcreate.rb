module Bot
  module Events
    # Ready event
    module ChannelCreateEvent
      extend Discordrb::EventContainer
      channel_create do |event|
        SCHEDULER.in '5s' do
          begin
            if Database::Room.channel_lookup(event.channel.id)
              while (!Database::Room.channel_lookup(event.channel.id).claimed)
                sleep(1)
              end
              
              nest_monster = Database::Monsters[rand(1..Database::Monsters.count)]
              player_monster = ['Aptonoth', 'Velocidrome', 'Arzuros', 'Yian Kut-Ku', 'Blue Yian Kut-Ku', 'Popo', 'Lagombi', 'Bulldrome', 'Zamtrios', 'Khezu'].sample
              hp = [50, 50, 50].sample
              description = if hp <= 150
                              'weak'
                            elsif hp > 150 and hp < 300
                              'average'
                            else
                              'strong'
                            end
              unguarded = if rand(0..3) == 0
                            true
                          else
                            false
                          end

              if unguarded
                event.channel.send_message("An egg sits in the nest unguarded!\n(Take/Leave)")
              else
                event.channel.send_message("#{nest_monster.name} guards the nest! It looks pretty #{description}. You can fight it to claim the egg it's guarding, or leave and let someone else have a go.\n(Fight/Run)")
                response = event.channel.await!(timeout: 120)
                if response
                  if ['Fight', 'fight'].include?(response.message.content)
                    event.channel.send_message 'Setting up fight! (Attack/Run)'
                  elsif ['Run', 'run'].include?(response.message.content)
                    event.channel.send_message "#{response.user.name} has ran from the nest!"
                    Database::Room.channel_lookup(event.channel.id).reject
                  end
                else
                  event.channel.delete
                end
              end

              loop do
                response = event.channel.await!(timeout: 120) # 300 for 5 mins
                if response
                  if unguarded
                    if ['Take', 'take'].include?(response.message.content)
                      event.channel.send_message "You took the egg!"
                      sleep(30)
                      break
                    elsif ['Leave', 'leave'].include?(response.message.content)
                      event.channel.send_message "#{response.user.name} has left an egg in the nest!"
                      Database::Room.channel_lookup(event.channel.id).reject
                    end
                  else
                    if ['Attack', 'attack'].include?(response.message.content)
                      roll = rand(1..20)
                      hp = hp - roll
                      event.channel.send_message "Your #{player_monster} did #{roll} damage to the #{nest_monster.name}!"
                    elsif ['Run', 'run'].include?(response.message.content)
                      event.channel.send_message "#{response.user.name} has ran from the nest!"
                      Database::Room.channel_lookup(event.channel.id).reject
                    end
                    if hp < 1
                      event.channel.send_message "The #{nest_monster.name} has died from it's wounds."
                      event.channel.send_message("An egg sits in the nest unguarded!\n(Take/Leave)")
                      unguarded = true
                    end
                  end
                else
                  break
                end
              end
              event.channel.delete
            end
          rescue => s
            puts s
          end
        end
      end
    end
  end
end
