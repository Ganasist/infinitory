class AddDefaultValueToDailyPoints < ActiveRecord::Migration
  def change
  	change_column :users, :daily_points, :integer, default: 0
    change_column :labs, :daily_points, :integer, default: 0
    change_column :departments, :daily_points, :integer, default: 0
    change_column :institutes, :daily_points, :integer, default: 0
  end
end
