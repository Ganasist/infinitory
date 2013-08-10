class AddUrlAndAcronymToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :url, :string
    add_column :departments, :acronym, :string
  end
end
