class AddSuperAdminAndGroupLeaderAndAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :super_admin, :boolean, default: false
    add_column :users, :group_leader, :boolean, default: false
    add_column :users, :admin, :boolean, default: false
  end
end
