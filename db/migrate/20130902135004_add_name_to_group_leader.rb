class AddNameToGroupLeader < ActiveRecord::Migration
  def change
    add_column :group_leaders, :name, :string
  end
end
