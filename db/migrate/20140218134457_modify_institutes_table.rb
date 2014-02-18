class ModifyInstitutesTable < ActiveRecord::Migration
  def change
  	change_column :institutes, :name, :string, null: false
  	remove_column :institutes, :longitude
  	remove_column :institutes, :latitude
  	remove_column :institutes, :city
  	remove_column :institutes, :country

  	change_column :departments, :name, :string, null: false
  	remove_column :departments, :longitude
  	remove_column :departments, :latitude
  	remove_column :departments, :city
  	remove_column :departments, :country

  	add_column		:reagents, :shared, :boolean, null: false, default: false
  	remove_column :reagents, :public
  	
  	add_column		:devices, :shared, :boolean, null: false, default: false
  	remove_column :devices, :public
  end
end
