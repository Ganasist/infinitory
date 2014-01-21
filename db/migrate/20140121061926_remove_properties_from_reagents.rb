class RemovePropertiesFromReagents < ActiveRecord::Migration
  def change
    remove_column :reagents, :properties, :hstore
  end
end
