class RemoveOwnerFromReagents < ActiveRecord::Migration
  def change
    remove_column :reagents, :owner, :string
  end
end
