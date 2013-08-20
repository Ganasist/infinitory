class AddIconToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :icon, :string
  end
end
