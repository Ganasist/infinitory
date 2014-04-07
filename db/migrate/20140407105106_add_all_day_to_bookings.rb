class AddAllDayToBookings < ActiveRecord::Migration
  def change
    add_column :bookings, :all_day, :boolean
  end
end
