Sequel.migration do
  up do
    create_table(:players) do
      primary_key :id
      Integer :discord_id
      Integer :hr, default: 0
      Integer :lvl, default: 0
      Integer :xp, default: 0
    end
  end

  down do
    drop_table(:players)
  end
end
