class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :name
      t.string :category
      t.string :location
      t.string :serial
      t.integer :lab_id
      t.integer :user_id
      t.string :url
      t.string :icon
      t.boolean :icon_processing
      t.integer :lock_version
      t.string :uid
      t.text :description
      t.decimal :price

      t.timestamps
    end

    add_index :devices, [:lab_id, :name, :uid, :category], unique: true
    add_index :devices, :lab_id
    add_index :devices, :user_id
  end
end