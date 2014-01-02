class ChangeUnitInReagentsToQuantity < ActiveRecord::Migration
  def change
  	rename_column :reagents, :unit, :quantity
  end
end
