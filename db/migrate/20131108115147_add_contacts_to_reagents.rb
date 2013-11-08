class AddContactsToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :contacts, :string
  end
end
