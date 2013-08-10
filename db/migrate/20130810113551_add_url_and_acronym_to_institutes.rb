class AddUrlAndAcronymToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :url, :string
    add_column :institutes, :acronym, :string
  end
end
