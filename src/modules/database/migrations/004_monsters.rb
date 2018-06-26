Sequel.migration do
  up do
    create_table(:monsters) do
      primary_key :id
      String :name
      String :desc
      String :EAtk
      String :ERes
      String :Habitat
      String :Growth
      String :default_attribute
      Integer :encount_radius
      String :lvl
    end
  end

  down do
    drop_table(:monsters)
  end
end
