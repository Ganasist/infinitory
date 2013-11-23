class AddEmailToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :email, :string
    add_index :departments, :email
  end
end
