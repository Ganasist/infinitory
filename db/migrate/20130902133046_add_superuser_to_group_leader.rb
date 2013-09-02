class AddSuperuserToGroupLeader < ActiveRecord::Migration
  def change
    add_column :group_leaders, :superuser, :boolean, default: false
  end
end
