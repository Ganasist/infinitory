class AddStatusToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :status, :boolean, default: true
  end
end
