class AddBookableToDevices < ActiveRecord::Migration
  def change
    add_column :devices, :bookable, :boolean, default: false
  end
end
