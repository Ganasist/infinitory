class AddRankToInstitutes < ActiveRecord::Migration
  def change
    add_column :institutes, :rank, :integer
  end
end
