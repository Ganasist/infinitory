class CreateLabs < ActiveRecord::Migration
  def change
    create_table :labs do |t|
      t.integer :department_id
      t.integer :institute_id
      t.string :group_leader
      t.string :group_leader_email

      t.timestamps
    end
    add_index :labs, :department_id
    add_index :labs, :institute_id
  end
end
