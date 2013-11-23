class AddUrlToReagents < ActiveRecord::Migration
  def change
    add_column :reagents, :url, :string
  end
end
