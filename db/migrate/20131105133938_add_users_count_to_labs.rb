class AddUsersCountToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :users_count, :integer, default: 0
  end
end
