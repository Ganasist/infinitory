class RemoveQuantityFromReagents < ActiveRecord::Migration
  def change
    remove_column :reagents, :quantity, :decimal
  end
end
