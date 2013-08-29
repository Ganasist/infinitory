class AddGroupLeaderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :group_leader, :boolean, default: false
  end
end
