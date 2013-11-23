class AddLabsCountToDepartmentsAndInstitutes < ActiveRecord::Migration
  def change
    add_column :departments, :labs_count, :integer, default: 0
    add_column :institutes, :labs_count, :integer, default: 0
  end
end
