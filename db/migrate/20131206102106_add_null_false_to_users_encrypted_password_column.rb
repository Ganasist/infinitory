class AddNullFalseToUsersEncryptedPasswordColumn < ActiveRecord::Migration
  def change
  	change_column :users, :encrypted_password, :string, default: "", null: false
  end
end
