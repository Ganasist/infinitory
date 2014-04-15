class AddDurationToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :duration, :integer
  end
end
