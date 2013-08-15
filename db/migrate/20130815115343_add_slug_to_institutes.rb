class AddSlugToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :slug, :string
    add_index :institutes, :slug, unique: true
  end
end
