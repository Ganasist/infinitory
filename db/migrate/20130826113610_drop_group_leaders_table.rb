class DropGroupLeadersTable < ActiveRecord::Migration
  def change
  	drop_table :group_leaders
  end
end
