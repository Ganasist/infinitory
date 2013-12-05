class AddUniquenessIndexToInstitutes < ActiveRecord::Migration
  def change
  	add_index :institutes, [:name, :address], unique: true
  end
end
