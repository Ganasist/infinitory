class ModifyPriceOnDevices < ActiveRecord::Migration
  def change
  	change_column :devices, :price, :decimal, precision: 9, scale: 2
  end
end
