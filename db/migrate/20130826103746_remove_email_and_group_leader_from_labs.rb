class RemoveEmailAndGroupLeaderFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :email, :string
    remove_column :labs, :group_leader, :string
  end
end
