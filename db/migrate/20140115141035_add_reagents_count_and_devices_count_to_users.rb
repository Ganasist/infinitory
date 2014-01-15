class AddReagentsCountAndDevicesCountToUsers < ActiveRecord::Migration
  def change
    add_column :users, :reagents_count, :integer, default: 0
    add_column :users, :devices_count, :integer, default: 0
  end
end
