class ChangeCategoryColumnsForReagentsAndDevices < ActiveRecord::Migration
  def change
  	remove_column :reagents, :category, :string
  	remove_column :devices, :category, :string
  end
end
