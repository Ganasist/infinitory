class RemoveRoleAndRolesMaskFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :role, :string
    remove_column :users, :roles_mask, :integer
  end
end
