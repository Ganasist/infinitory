class AddPropertiesToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :properties, :hstore
  end
end
