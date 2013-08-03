class CreateDepartments < ActiveRecord::Migration
  def change
    create_table :departments do |t|
      t.string :name
      t.integer :institute_id
      t.string :address
      t.float :longitude
      t.float :latitude

      t.timestamps
    end

    add_index :departments, :institute_id

  end
end
