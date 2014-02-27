class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :braintree_customer_id
      t.date :billing_start
      t.integer :billing_day
      t.boolean :invoice
      t.string :vat_number

      t.timestamps
    end
  end
end
