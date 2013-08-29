class RemoveGroupLeaderIdFromUsers < ActiveRecord::Migration
  def change
  	remove_column :users, :group_leader_id
  end
end
