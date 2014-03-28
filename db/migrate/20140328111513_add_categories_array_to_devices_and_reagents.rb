class AddCategoriesArrayToDevicesAndReagents < ActiveRecord::Migration
  def change
  	add_column :devices, :category, :text, array: true, default: '{}'
  	add_column :reagents, :category, :text, array: true, default: '{}'

  	add_index  :devices, :category, using: 'gin'
  	add_index  :reagents, :category, using: 'gin'
  end
end
