class AddReagentsCountToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :reagents_count, :integer, default: 0
  end
end
