class RemoveAcronymFromDepartments < ActiveRecord::Migration
  def change
    remove_column :departments, :acronym, :string
  end
end
