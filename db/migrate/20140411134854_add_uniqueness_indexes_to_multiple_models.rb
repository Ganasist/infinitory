class AddUniquenessIndexesToMultipleModels < ActiveRecord::Migration
  def change
  	remove_index :departments, :email
  	remove_index :institutes, :email
  	add_index :collaborations, [:lab_id, :collaborator_id], unique: true
  	add_index :devices, [:lab_id, :name, :uid], unique: true
  	add_index :departments, :email, unique: true
  	add_index :institutes, :email, unique: true
  	add_index :ownerships, [:user_id, :reagent_id], unique: true
  	add_index :ownerships, [:user_id, :device_id], unique: true
  	add_index :reagents, [:lab_id, :name, :uid, :description], unique: true
  end
end
