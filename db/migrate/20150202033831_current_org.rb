class CurrentOrg < ActiveRecord::Migration
  def change
    add_column :devices, :current_org, :integer
  end
end
