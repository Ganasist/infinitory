class AddNameToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :name, :string
  end
end
