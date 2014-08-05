class RemoveSlugIndexFromInstitutes < ActiveRecord::Migration
  def change
  	remove_index :institutes, :slug
  end
end
