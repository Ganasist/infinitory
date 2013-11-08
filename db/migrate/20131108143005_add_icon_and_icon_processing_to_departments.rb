class AddIconAndIconProcessingToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :icon, :string
    add_column :departments, :icon_processing, :boolean
  end
end
