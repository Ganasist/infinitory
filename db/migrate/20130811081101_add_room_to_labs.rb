class AddRoomToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :room, :string
  end
end
