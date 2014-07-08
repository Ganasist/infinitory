class AddBuildingToLab < ActiveRecord::Migration
  def change
    add_column :labs, :building, :string
  end
end
