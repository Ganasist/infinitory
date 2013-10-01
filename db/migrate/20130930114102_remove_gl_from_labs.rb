class RemoveGlFromLabs < ActiveRecord::Migration
  def change
    remove_column :labs, :gl, :string
  end
end
