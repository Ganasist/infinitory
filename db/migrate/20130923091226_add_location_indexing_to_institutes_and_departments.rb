class AddLocationIndexingToInstitutesAndDepartments < ActiveRecord::Migration
  def change
  	add_index :institutes, [:latitude, :longitude]
  	add_index :departments, [:latitude, :longitude]
  end
end
