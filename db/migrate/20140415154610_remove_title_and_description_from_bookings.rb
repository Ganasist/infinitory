class RemoveTitleAndDescriptionFromBookings < ActiveRecord::Migration
  def change
    remove_column :bookings, :title, :string
    remove_column :bookings, :description, :text
  end
end
