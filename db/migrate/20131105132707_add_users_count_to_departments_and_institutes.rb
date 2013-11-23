class AddUsersCountToDepartmentsAndInstitutes < ActiveRecord::Migration
  def change
  	add_column :institutes, :users_count, :integer, default: 0
  	add_column :departments, :users_count, :integer, default: 0
  end
end
