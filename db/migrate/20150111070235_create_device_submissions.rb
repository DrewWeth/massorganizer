class CreateDeviceSubmissions < ActiveRecord::Migration
  def change
    create_table :device_submissions do |t|
      t.integer :device_id, :index => true
      t.text :message

      t.timestamps
    end
  end
end
