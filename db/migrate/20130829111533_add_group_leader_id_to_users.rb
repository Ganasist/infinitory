class AddGroupLeaderIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_leader_id, :integer
    add_index :users, :group_leader_id
  end
end
