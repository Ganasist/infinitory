class RemoveGmapsFromDepartmentsAndInstitutes < ActiveRecord::Migration
  def change
    remove_column :departments, :gmaps, :boolean
    remove_column :institutes, :gmaps, :boolean
  end
end
