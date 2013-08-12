class ChangeAddressFormats < ActiveRecord::Migration
  def self.up
   change_column :departments, :address, :text
   change_column :institutes, :address, :text
  end

  def self.down
   change_column :institutes, :address, :string
   change_column :departments, :address, :string
  end
end
