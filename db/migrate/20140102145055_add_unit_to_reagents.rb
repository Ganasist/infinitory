class AddUnitToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :unit, :string
  end
end
