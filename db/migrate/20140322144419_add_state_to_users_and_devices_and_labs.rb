class AddStateToUsersAndDevicesAndLabs < ActiveRecord::Migration
  def change
    add_column :users, :state, :string
    add_column :devices, :state, :string
    add_column :labs, :state, :string
  end
end
