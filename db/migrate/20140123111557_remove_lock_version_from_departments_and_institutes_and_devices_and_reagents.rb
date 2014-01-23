class RemoveLockVersionFromDepartmentsAndInstitutesAndDevicesAndReagents < ActiveRecord::Migration
  def change
    remove_column :institutes, :lock_version, :integer
    remove_column :departments, :lock_version, :integer
    remove_column :devices, :lock_version, :integer
    remove_column :reagents, :lock_version, :integer
  end
end
