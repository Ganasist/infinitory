class AddDevicesCountToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :devices_count, :integer, default: 0
  end
end
