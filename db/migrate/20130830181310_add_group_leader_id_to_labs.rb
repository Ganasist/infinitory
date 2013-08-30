class AddGroupLeaderIdToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :group_leader_id, :integer
    add_index :labs, :group_leader_id
  end
end
