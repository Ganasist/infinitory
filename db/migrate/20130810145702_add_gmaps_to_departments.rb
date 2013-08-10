class AddGmapsToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :gmaps, :boolean
  end
end
