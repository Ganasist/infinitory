class AddLabIdToGroupLeaders < ActiveRecord::Migration
  def change
    add_column :group_leaders, :lab_id, :integer
    add_index :group_leaders, :lab_id
  end
end
