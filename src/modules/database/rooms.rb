module Bot
  module Database
    # Room table
    class Room < Sequel::Model
      
      def self.create_channel(id)
        find(channel_id: id) || create(channel_id: id)
      end
      
      def self.channel_lookup(id)
        find(channel_id: id)
      end
      
      def self.creation_message(id)
        find(message_id: id)
      end
      
      def add_message(id)
        update(message_id: id)
      end
      
      def delete_channel
        update(deleted: true)
      end
        
      def add_spawner(id)
        update(spawner_id: id)
      end
      
      def add_owner(id)
        update(owner_id: id)
      end
      
      def claim(id)
        update(claimed: true)
        update(claimer_id: id)
      end
      
      def reject
        update(rejected: true)
        update(claimed: false)
      end
      
      
    end
  end
end
