class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :email
      t.string :institute
      t.string :department

      t.timestamps
    end
  end
end
