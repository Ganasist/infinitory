class RemoveSubtitlesFromBlogsAndAddBitlyUrl < ActiveRecord::Migration
  def change
  	remove_column :blogs, :subtitle, :string
  	add_column :blogs, :bitly_url, :string
  end
end
