class AddSearchIndexToReagentsAndDevices < ActiveRecord::Migration
  def change
  	add_column :reagents, :tsv_body, :tsvector
  	add_column :devices, :tsv_body, :tsvector

  	add_index :reagents, :tsv_body, using: 'gin'
  	add_index :devices, :tsv_body, using: 'gin'
  end
end
