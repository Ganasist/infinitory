class AddNameIndexToDepartments < ActiveRecord::Migration
  def change
  	add_index :departments, [ :name, :institute_id], unique: true
  end
end
