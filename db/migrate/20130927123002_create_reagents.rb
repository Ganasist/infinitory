class CreateReagents < ActiveRecord::Migration
  def change
    create_table :reagents do |t|
      t.string :name, default: nil, null: false
      t.string :category, default: nil, null: false
      t.string :owner, default: nil, null: false
      t.string :location
      t.decimal :price, precision: 9, scale: 2
      t.string :serial
      t.decimal :quantity, precision: 3

      t.timestamps
    end

  end
end
