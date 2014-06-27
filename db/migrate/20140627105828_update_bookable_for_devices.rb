class UpdateBookableForDevices < ActiveRecord::Migration
  def change
  	remove_column :devices, :bookable, :boolean, default: false
  	add_column :devices, :bookable, :boolean, default: false, null: false
  end
end
