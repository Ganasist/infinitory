class RemoveSingularLocationIndexesFromInstitutes < ActiveRecord::Migration
  def change
  	remove_index :institutes, :latitude
  	remove_index :institutes, :longitude
  end
end
