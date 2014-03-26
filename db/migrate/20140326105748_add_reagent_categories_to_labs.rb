class AddReagentCategoriesToLabs < ActiveRecord::Migration
  def change
  	add_column :labs, :reagent_categories, :text, array: true, default: []
  	add_column :labs, :device_categories, :text, array: true, default: []
  end
end
