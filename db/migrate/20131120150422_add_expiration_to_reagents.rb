class AddExpirationToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :expiration, :date
  end
end
