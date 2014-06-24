class AddSparklinePointsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :sparkline_points, :integer, array: true, length: 60, default: [0], null: false
  end
end
