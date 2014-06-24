class RemovePointsFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :points, :integer
  end
end
