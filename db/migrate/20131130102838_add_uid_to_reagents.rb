class AddUidToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :UID, :string
    add_index :reagents, [:lab_id, :name, :UID], unique: true
    add_index :reagents, [:lab_id, :serial, :UID], unique: true
  end
end
