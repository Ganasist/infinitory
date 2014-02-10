class AddImageProcessingToModels < ActiveRecord::Migration
  def change
  	add_column :institutes, :icon_processing, :boolean
  	add_column :departments, :icon_processing, :boolean
  	add_column :labs, :icon_processing, :boolean
  	add_column :users, :icon_processing, :boolean
  	add_column :devices, :icon_processing, :boolean
  	add_column :reagents, :icon_processing, :boolean
  end
end
