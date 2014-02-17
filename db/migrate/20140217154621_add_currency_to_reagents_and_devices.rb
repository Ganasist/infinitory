class AddCurrencyToReagentsAndDevices < ActiveRecord::Migration
  def change
    add_column :reagents, :currency, :string, default: "$"
    add_column :devices, :currency, :string, default: "$"
  end
end
