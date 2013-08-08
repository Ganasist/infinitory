class AddGmapsToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :gmaps, :boolean
  end
end
