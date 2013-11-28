class AddIconAndIconProcessingToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :icon, :string
    add_column :reagents, :icon_processing, :boolean
  end
end
