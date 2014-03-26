class AddIndexToReagentAndDeviceCategoriesInLabs < ActiveRecord::Migration
  def change
  	add_index :labs, :device_categories, using: 'gin'
  	add_index :labs, :reagent_categories, using: 'gin'
  end
end
