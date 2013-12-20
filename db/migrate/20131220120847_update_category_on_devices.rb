class UpdateCategoryOnDevices < ActiveRecord::Migration
  def change
  	change_column :devices, :category, :string, null: false
  end
end
