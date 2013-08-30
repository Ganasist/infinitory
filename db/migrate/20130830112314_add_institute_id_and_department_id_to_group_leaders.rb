class AddInstituteIdAndDepartmentIdToGroupLeaders < ActiveRecord::Migration
  def change
    add_column :group_leaders, :institute_id, :integer
    add_index :group_leaders, :institute_id
    add_column :group_leaders, :department_id, :integer
    add_index :group_leaders, :department_id
  end
end
