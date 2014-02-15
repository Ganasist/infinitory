class AddFieldsToDepartments < ActiveRecord::Migration
  def self.up
    add_column :departments, :sash_id, :integer
    add_column :departments, :level, :integer, :default => 0
  end

  def self.down
    remove_column :departments, :sash_id
    remove_column :departments, :level
  end
end
