class AddFieldsToLabs < ActiveRecord::Migration
  def self.up
    add_column :labs, :sash_id, :integer
    add_column :labs, :level, :integer, :default => 0
  end

  def self.down
    remove_column :labs, :sash_id
    remove_column :labs, :level
  end
end
