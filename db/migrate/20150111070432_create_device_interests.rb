class CreateDeviceInterests < ActiveRecord::Migration
  def change
    create_table :device_interests do |t|
      t.integer :device_id, :index => true
      t.integer :interest_id, :index => true

      t.timestamps
    end
  end
end
