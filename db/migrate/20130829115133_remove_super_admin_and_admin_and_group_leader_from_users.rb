class RemoveSuperAdminAndAdminAndGroupLeaderFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :super_admin, :boolean
    remove_column :users, :admin, :boolean
    remove_column :users, :group_leader, :boolean
  end
end
