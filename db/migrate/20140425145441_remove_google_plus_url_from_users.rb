class RemoveGooglePlusUrlFromUsers < ActiveRecord::Migration
  def change
    remove_column :users, :google_plus_url, :string
    remove_column :labs, :google_plus_url, :string
    remove_column :departments, :google_plus_url, :string
    remove_column :institutes, :google_plus_url, :string
  end
end