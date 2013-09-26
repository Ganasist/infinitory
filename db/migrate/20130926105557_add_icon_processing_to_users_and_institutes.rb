class AddIconProcessingToUsersAndInstitutes < ActiveRecord::Migration
  def change
    add_column :users, :icon_processing, :boolean
    add_column :institutes, :icon_processing, :boolean
  end
end
