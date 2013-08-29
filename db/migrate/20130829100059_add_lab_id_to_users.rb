class AddLabIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lab_id, :integer
    add_index :users, :lab_id
  end
end
