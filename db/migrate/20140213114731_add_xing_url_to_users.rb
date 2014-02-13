class AddXingUrlToUsers < ActiveRecord::Migration
  def change
    add_column :users, :xing_url, :string
  end
end
