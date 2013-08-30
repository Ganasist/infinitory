class RemoveLabIdFromGroupLeaders < ActiveRecord::Migration
  def change
    remove_index :group_leaders, :lab_id
    remove_column :group_leaders, :lab_id, :integer
  end
end
