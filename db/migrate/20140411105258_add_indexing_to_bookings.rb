class AddIndexingToBookings < ActiveRecord::Migration
  def change
  	add_index :bookings, :start_time
  	add_index :bookings, :end_time
  end
end