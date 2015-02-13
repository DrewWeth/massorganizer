class CreateDeviceMemberships < ActiveRecord::Migration
  def change
    create_table :device_memberships do |t|
      t.integer :device_id, :index=>true
      t.integer :organization_id, :index=>true

      t.timestamps
    end
  end
end
