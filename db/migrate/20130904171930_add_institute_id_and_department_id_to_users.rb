class AddInstituteIdAndDepartmentIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :institute_id, :integer
    add_index :users, :institute_id
    add_column :users, :department_id, :integer
    add_index :users, :department_id
  end
end
