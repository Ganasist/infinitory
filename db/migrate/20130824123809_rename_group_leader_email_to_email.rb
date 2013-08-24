class RenameGroupLeaderEmailToEmail < ActiveRecord::Migration
  def change
  	rename_column :labs, :group_leader_email, :email
  end
end
