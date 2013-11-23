class AddIconProcessingToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :icon_processing, :boolean
  end
end
