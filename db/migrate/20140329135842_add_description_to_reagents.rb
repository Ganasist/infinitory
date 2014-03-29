class AddDescriptionToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :description, :text, null: true
  end
end
