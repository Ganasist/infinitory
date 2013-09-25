class AddSlugToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :slug, :string
    add_index	 :labs, :slug, unique: true
  end
end
