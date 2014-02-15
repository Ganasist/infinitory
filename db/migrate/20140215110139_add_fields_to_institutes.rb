class AddFieldsToInstitutes < ActiveRecord::Migration
  def self.up
    add_column :institutes, :sash_id, :integer
    add_column :institutes, :level, :integer, :default => 0
  end

  def self.down
    remove_column :institutes, :sash_id
    remove_column :institutes, :level
  end
end
