class ChangeNamesForUrls < ActiveRecord::Migration
  def change
  	rename_column :devices, :url, :product_url
  	rename_column :devices, :purchasing_site, :purchasing_url
  	rename_column :reagents, :url, :product_url
  	rename_column :reagents, :purchasing_site, :purchasing_url
  end
end
