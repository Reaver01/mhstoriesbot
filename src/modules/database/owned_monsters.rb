module Bot
  module Database
    # Item table
    class OwnedMonsters < Sequel::Model
      many_to_one :player
      many_to_one :monster
    end
  end
end
