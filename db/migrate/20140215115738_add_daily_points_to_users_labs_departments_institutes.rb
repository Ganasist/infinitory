class AddDailyPointsToUsersLabsDepartmentsInstitutes < ActiveRecord::Migration
  def change
    add_column :users, :daily_points, :decimal, precision: 4, scale: 1
    add_column :labs, :daily_points, :decimal, precision: 4, scale: 1
    add_column :departments, :daily_points, :decimal, precision: 4, scale: 1
    add_column :institutes, :daily_points, :decimal, precision: 4, scale: 1
  end
end
