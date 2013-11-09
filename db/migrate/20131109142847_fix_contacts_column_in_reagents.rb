class FixContactsColumnInReagents < ActiveRecord::Migration
  def change
  	rename_column :reagents, :contacts, :contact
  end
end