class AddCityAndCountryToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :city, :string
    add_column :departments, :country, :string
  end
end
