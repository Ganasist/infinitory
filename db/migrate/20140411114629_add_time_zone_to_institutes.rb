class AddTimeZoneToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :time_zone, :string
  end
end
