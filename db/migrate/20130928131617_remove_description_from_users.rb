class RemoveDescriptionFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :description, :string
  end
end
