class RemoveSuperuserFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :superuser, :boolean
  end
end
