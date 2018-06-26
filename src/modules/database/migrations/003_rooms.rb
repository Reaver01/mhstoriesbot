Sequel.migration do
  up do
    create_table(:rooms) do
      primary_key :id
      Integer :channel_id
      Integer :message_id, default: 0
      Integer :spawner_id, default: 0
      Integer :owner_id, default: 0
      Integer :claimer_id, default: 0
      TrueClass :claimed, default: false
      TrueClass :rejected, default: false
      TrueClass :deleted, default: false
      DateTime :created, default: Time.now
      
    end
  end

  down do
    drop_table(:rooms)
  end
end
