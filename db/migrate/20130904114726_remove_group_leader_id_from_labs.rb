class RemoveGroupLeaderIdFromLabs < ActiveRecord::Migration
  def change
    remove_index :labs, :group_leader_id
    remove_column :labs, :group_leader_id, :integer
  end
end
