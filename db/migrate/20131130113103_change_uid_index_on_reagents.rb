class ChangeUidIndexOnReagents < ActiveRecord::Migration
  def change
  	remove_index :reagents, name: "index_reagents_on_lab_id_and_name_and_uid"
  	add_index :reagents, [:lab_id, :uid, :name, :category], unique: true
  end
end
