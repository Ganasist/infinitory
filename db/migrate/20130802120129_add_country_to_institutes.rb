class AddCountryToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :country, :string
  end
end
