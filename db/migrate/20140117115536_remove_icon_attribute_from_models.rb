class RemoveIconAttributeFromModels < ActiveRecord::Migration
  def change
  	remove_column :institutes, :icon
  	remove_column :institutes, :icon_processing
  	remove_column :departments, :icon
  	remove_column :departments, :icon_processing
  	remove_column :labs, :icon
  	remove_column :labs, :icon_processing
  	remove_column :users, :icon
  	remove_column :users, :icon_processing
  	remove_column :devices, :icon
  	remove_column :devices, :icon_processing
  	remove_column :reagents, :icon
  	remove_column :reagents, :icon_processing
  end
end
