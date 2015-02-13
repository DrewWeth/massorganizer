class OrgScope < ActiveRecord::Migration
  def change
    add_column :device_interests, :organization_id, :integer, :index=>true
  end
end
