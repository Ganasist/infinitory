class RemoveEmailFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :email, :string
  end
end
