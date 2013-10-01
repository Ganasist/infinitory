class AddGlToLabs < ActiveRecord::Migration
  def change
    add_column :labs, :gl, :string
  end
end
