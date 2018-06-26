module Bot
  module Database
    # Player table
    class Player < Sequel::Model
      one_to_many :owned_monsters
      
      def self.new_player(id)
        create(discord_id: id)
      end
      
      def self.player(id)
        find(discord_id: id) || false
      end
      
      def user
        BOT.user discord_id
      end
      
      def monster(monster)
        owned_monsters.find { |i| i.monster_id == monster.id }
      end
    end
  end
end
