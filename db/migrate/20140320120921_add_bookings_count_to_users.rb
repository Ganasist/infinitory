class AddBookingsCountToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :bookings_count, :integer, default: 0
  end
end
