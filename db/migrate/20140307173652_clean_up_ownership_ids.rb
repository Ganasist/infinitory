class CleanUpOwnershipIds < ActiveRecord::Migration
  def change
  	remove_column :devices, :user_id, :integer
  	remove_column :reagents, :user_id, :integer
  end
end
