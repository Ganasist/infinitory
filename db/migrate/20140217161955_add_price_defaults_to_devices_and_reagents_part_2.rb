class AddPriceDefaultsToDevicesAndReagentsPart2 < ActiveRecord::Migration
  def change
  	change_column :devices, :price, :decimal, precision: 9, scale: 2, default: 0.00, null: false
  	change_column :reagents, :price, :decimal, precision: 9, scale: 2, default: 0.00, null: false
  end
end
