class AddCounterCachesForJoinModels < ActiveRecord::Migration
  def change
  	change_column :devices, :bookings_count, :integer, default: 0

  	add_column :devices, :users_count, :integer, default: 0
  	add_column :reagents, :users_count, :integer, default: 0
  end
end
