class AddEmailToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :email, :string
    add_index :institutes, :email
  end
end
