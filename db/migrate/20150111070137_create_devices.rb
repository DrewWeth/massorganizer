class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :tele
      t.string :name
      t.string :pawprint
      t.string :email

      t.timestamps
    end
  end
end
