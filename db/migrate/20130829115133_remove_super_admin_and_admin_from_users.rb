class RemoveSuperAdminAndAdminFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :super_admin, :boolean
    remove_column :users, :admin, :boolean
  end
end
