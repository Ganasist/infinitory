class AddIndexesToInstitutes < ActiveRecord::Migration
  def change
    add_index :institutes, :longitude
    add_index :institutes, :latitude
  end
end
