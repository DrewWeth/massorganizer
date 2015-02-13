class OrgId < ActiveRecord::Migration
  def change
    add_column :organizations, :org_key, :string, :index=>true
  end
end
