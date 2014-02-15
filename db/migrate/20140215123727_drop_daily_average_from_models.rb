class DropDailyAverageFromModels < ActiveRecord::Migration
  def change
  	remove_column :departments, :daily_average
  	remove_column :institutes, :daily_average
  	remove_column :labs, :daily_average
  	remove_column :users, :daily_average
  end
end
