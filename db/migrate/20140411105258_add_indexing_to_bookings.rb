class AddIndexingToBookings < ActiveRecord::Migration
  def change
  	add_index :bookings, [:device_id, :start_time, :end_time], unique: true
  end
end
