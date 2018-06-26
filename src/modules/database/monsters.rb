module Bot
  module Database
    # Item table
    class Monsters < Sequel::Model
      one_to_many :owned_monsters
    end
  end
end
