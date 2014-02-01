class AddSocialToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :twitter_url, :string
  	add_column :users, :facebook_url, :string
  	add_column :users, :google_plus_url, :string
  end
end
