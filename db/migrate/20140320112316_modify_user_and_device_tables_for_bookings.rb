class ModifyUserAndDeviceTablesForBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.integer :user_id, null: false
      t.integer :device_id, null: false
      t.timestamps
    end

    add_index :bookings, :user_id
    add_index :bookings, :device_id
  end
end