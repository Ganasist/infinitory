class RemoveRoomFromDepartments < ActiveRecord::Migration
  def change
    remove_column :departments, :room, :string
  end
end
