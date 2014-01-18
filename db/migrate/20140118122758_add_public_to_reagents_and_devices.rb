class AddPublicToReagentsAndDevices < ActiveRecord::Migration
  def change
    add_column :reagents, :public, :boolean, default: false
    add_column :devices, :public, :boolean, default: false
  end
end
