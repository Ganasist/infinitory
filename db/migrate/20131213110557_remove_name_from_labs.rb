class RemoveNameFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :name, :string
  end
end
