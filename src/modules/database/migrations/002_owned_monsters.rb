Sequel.migration do
  up do
    create_table(:owned_monsters) do
      primary_key :id
      foreign_key :player_id, :players
      foreign_key :monster_id, :monsters
      Integer :level, default: 1
      Integer :hp, default: 0
    end
  end

  down do
    drop_table(:owned_monsters)
  end
end
