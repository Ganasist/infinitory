class RemoveDescriptionFromInstitutes < ActiveRecord::Migration
  def change
    remove_column :institutes, :description, :text
  end
end
