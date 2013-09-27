class AddLabIdToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :lab_id, :integer
    add_index :reagents, :lab_id
  end
end
