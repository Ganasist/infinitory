class RemoveIndexesFromReagents < ActiveRecord::Migration
  def change
  	remove_column :reagents, :tsv_name, :tsvector
  end
end
