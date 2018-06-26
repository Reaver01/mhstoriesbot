Sequel.migration do
  up do
    create_table(:monsters) do
      primary_key :id
      String :name
      String :image
      String :EAtk
      String :ERes
      String :Habitat
      String :Growth
      String :default_attribute
      Integer :encount_radius
      String :lv1
      String :lv5
      String :lv10
      String :lv15
      String :lv20
      String :lv25
      String :lv30
      String :lv35
      String :lv40
      String :lv45
      String :lv50
      String :lv55
      String :lv60
      String :lv65
      String :lv70
      String :lv75
      String :lv80
      String :lv85
      String :lv90
      String :lv95
      String :lv99
    end
  end

  down do
    drop_table(:monsters)
  end
end
