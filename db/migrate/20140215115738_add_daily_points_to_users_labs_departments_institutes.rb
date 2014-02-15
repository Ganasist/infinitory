class AddDailyPointsToUsersLabsDepartmentsInstitutes < ActiveRecord::Migration
  def change
    add_column :users, :daily_points, :integer
    add_column :labs, :daily_points, :integer
    add_column :departments, :daily_points, :integer
    add_column :institutes, :daily_points, :integer
  end
end
