class AddPaymentProcessorSubscriptionIdToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :payment_processor_subscription_id, :integer, default: nil
  end
end
