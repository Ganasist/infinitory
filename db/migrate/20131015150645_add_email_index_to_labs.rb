class AddEmailIndexToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :email, :string
    add_index :labs, :email
  end
end