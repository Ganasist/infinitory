class AddDefaultsToIcons < ActiveRecord::Migration
  def change
  	change_column :reagents, :icon, :string, default: nil
  	change_column :users, :icon, :string, default: nil
  	change_column :labs, :icon, :string, default: nil
  	change_column :institutes, :icon, :string, default: nil
  end
end

