class RemoveGroupLeaderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :group_leader
  end
end
