class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :desc
      t.string :phone_number
      t.integer :owner_id, :index => true

      t.timestamps
    end
  end
end
