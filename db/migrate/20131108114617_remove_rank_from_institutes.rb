class RemoveRankFromInstitutes < ActiveRecord::Migration
  def change
    remove_column :institutes, :rank, :integer
  end
end
