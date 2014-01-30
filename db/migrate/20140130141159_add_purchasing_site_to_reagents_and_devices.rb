class AddPurchasingSiteToReagentsAndDevices < ActiveRecord::Migration
  def change
    add_column :devices, :purchasing_site, :string
    add_column :reagents, :purchasing_site, :string
  end
end
