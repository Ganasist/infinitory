class AddExpirationIndexToReagents < ActiveRecord::Migration
  def change
  	add_index :reagents, :expiration
  end
end
