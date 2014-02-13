class AddSocialLinksToLabsDepartmentsInstitutes < ActiveRecord::Migration
  def change
  	add_column :labs, :linkedin_url, :string
  	add_column :labs, :twitter_url, :string
  	add_column :labs, :xing_url, :string
  	add_column :labs, :facebook_url, :string
  	add_column :labs, :google_plus_url, :string

  	add_column :departments, :linkedin_url, :string
  	add_column :departments, :twitter_url, :string
  	add_column :departments, :xing_url, :string
  	add_column :departments, :facebook_url, :string
  	add_column :departments, :google_plus_url, :string

  	add_column :institutes, :linkedin_url, :string
  	add_column :institutes, :twitter_url, :string
  	add_column :institutes, :xing_url, :string
  	add_column :institutes, :facebook_url, :string
  	add_column :institutes, :google_plus_url, :string
  end
end
