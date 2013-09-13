class AddJoinedToUsers < ActiveRecord::Migration
  def change
    add_column :users, :joined, :datetime
  end
end
