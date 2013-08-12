class AddRoomToDepartments < ActiveRecord::Migration
  def change
    add_column :departments, :room, :string
  end
end
