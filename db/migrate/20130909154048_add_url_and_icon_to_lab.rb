class AddUrlAndIconToLab < ActiveRecord::Migration
  def change
    add_column :labs, :url, :string
    add_column :labs, :icon, :string
  end
end
