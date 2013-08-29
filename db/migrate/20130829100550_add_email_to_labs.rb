class AddEmailToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :email, :string
  end
end
