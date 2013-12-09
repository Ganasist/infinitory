class RemoveLockVersionFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :lock_version, :integer
  end
end
