class AddEmailIndexToLabs < ActiveRecord::Migration
  def change
    add_index :labs, :email, unique: true
  end
end
