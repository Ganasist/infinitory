class AddEmailToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :email, :string, unique: true
  end
end
