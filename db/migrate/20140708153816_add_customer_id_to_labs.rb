class AddCustomerIdToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :customer_id, :integer, default: nil
  end
end
