class CreateDeviceLogs < ActiveRecord::Migration
  def change
    create_table :device_logs do |t|
      t.integer :device_id, :index=>true
      t.text :message
      t.string :to
      t.string :from

      t.timestamps
    end
  end
end
