class AddPriceDefaultsToDevicesAndReagents < ActiveRecord::Migration
  def change
  	change_column :devices, :price, :decimal, precision: 9, scale: 2, default: 0.00
  	change_column :reagents, :price, :decimal, precision: 9, scale: 2, default: 0.00
  end
end
