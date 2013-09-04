class RemoveLabManagerAndGroupLeaderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :lab_manager, :boolean
    remove_column :users, :group_leader, :boolean
  end
end
