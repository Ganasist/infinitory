class RenameUidToUidInReagents < ActiveRecord::Migration
  def change
  	rename_column :reagents, :UID, :uid
  end
end
