class CreateInstitutes < ActiveRecord::Migration
  def change
    create_table :institutes do |t|
      t.string :name
      t.text :description
      t.float :latitude
      t.float :longitude
      t.string :city
      t.string :address

      t.timestamps
    end
  end
end
