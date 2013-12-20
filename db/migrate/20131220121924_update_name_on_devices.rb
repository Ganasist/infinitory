class UpdateNameOnDevices < ActiveRecord::Migration
  def change
  	change_column :devices, :name, :string, null: false
  end
end
