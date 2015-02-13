class InterestOrgScope < ActiveRecord::Migration
  def change
    add_column :interests, :rel_interest_id, :integer
    add_column :organizations, :interest_count, :integer, :default => 1, :null => false
  end
end
