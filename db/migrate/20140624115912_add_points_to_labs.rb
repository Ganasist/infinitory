class AddPointsToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :sparkline_points, :integer, array: true, length: 60, default: [0], null: false
    add_column :labs, :points, :integer, default: 0
  end
end
