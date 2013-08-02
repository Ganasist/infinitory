class AddAlternateNameToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :alternate_name, :string
  end
end
