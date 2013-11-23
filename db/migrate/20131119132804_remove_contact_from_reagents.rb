class RemoveContactFromReagents < ActiveRecord::Migration
  def change
    remove_column :reagents, :contact, :string
  end
end
