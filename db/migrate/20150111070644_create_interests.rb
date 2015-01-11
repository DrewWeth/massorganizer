class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.string :name
      t.integer :organization_id, :index => true
      t.text :desc
      t.string :main_email

      t.timestamps
    end
  end
end
