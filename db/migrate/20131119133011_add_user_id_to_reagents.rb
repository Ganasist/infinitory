class AddUserIdToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :user_id, :integer
    add_index :reagents, :user_id
  end
end
