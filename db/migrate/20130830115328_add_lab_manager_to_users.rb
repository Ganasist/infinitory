class AddLabManagerToUsers < ActiveRecord::Migration
  def change
    add_column :users, :lab_manager, :boolean, default: false
  end
end
