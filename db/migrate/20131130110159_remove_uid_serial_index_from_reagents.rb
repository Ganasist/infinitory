class RemoveUidSerialIndexFromReagents < ActiveRecord::Migration
  def change
  	remove_index :reagents, name: "index_reagents_on_lab_id_and_serial_and_UID"
  end
end
