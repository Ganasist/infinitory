class CreateBookings < ActiveRecord::Migration
  def change
    create_table :bookings do |t|
      t.string :title
      t.text :description
      t.datetime :start_time
      t.datetime :end_time
      t.integer :device_id
      t.integer :user_id

      t.timestamps
    end
    add_index :bookings, :device_id
    add_index :bookings, :user_id
  end
end
