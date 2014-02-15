class AddDailyAverageToUsersAndLabsAndDepartmentsAndInstitutes < ActiveRecord::Migration
  def change
    add_column :users, :daily_average, :integer
    add_column :labs, :daily_average, :integer
    add_column :departments, :daily_average, :integer
    add_column :institutes, :daily_average, :integer
  end
end
