class Drop < ActiveRecord::Migration
  def change
  	drop_table :labs
  end
end
