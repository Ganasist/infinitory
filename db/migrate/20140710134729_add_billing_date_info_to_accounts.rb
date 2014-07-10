class AddBillingDateInfoToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :billing_start, :date
    add_column :accounts, :billing_day, :integer
    add_column :accounts, :vat_number, :string
  end
end
