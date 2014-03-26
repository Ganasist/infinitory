class AllowNullForCategoryValuesReagentAndDevice < ActiveRecord::Migration
  def change
  	change_column :devices, :category, :string, null: true
  	change_column :reagents, :category, :string, null: true
  end
end
