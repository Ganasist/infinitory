class AddLockingColumnToModels < ActiveRecord::Migration
  def change
  	add_column :reagents, :lock_version, :integer, default: 0, null: false
  	add_column :labs, :lock_version, :integer, default: 0, null: false
    add_column :departments, :lock_version, :integer, default: 0, null: false
    add_column :institutes, :lock_version, :integer, default: 0, null: false
  end
end