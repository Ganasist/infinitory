class DropVersionsTable < ActiveRecord::Migration
  def change
  	drop_table :versions
  end
end
