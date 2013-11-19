class AddConsumeableToReagents < ActiveRecord::Migration
  def change
    add_reference :reagents, :consumeable, polymorphic: true, index: true
  end
end
