class AddBookingsCountToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :bookings_count, :integer
  end
end
