class RemoveSlugFromLabs < ActiveRecord::Migration
  def change
    remove_index :labs, :slug
  end
end
