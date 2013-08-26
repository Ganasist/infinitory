class CreateGroupLeaders < ActiveRecord::Migration
  def change
    create_table :group_leaders do |t|
      t.string :name
      t.string :email
      t.boolean :admin, default: true

      t.timestamps
    end
  end
end
