class ChangeColumnLockVersionOnDevices < ActiveRecord::Migration
  def change
  	change_column :devices, :lock_version, :integer, default: 0, null: false
  end
end
