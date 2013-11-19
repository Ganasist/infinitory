class AddConsumableToReagents < ActiveRecord::Migration
  def change
    add_reference :reagents, :consumable, polymorphic: true, index: true
  end
end
