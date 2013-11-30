class AddLotNumberToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :lot_number, :string
  end
end
