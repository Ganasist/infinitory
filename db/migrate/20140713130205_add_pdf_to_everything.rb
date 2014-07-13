class AddPdfToEverything < ActiveRecord::Migration
  def self.up
    change_table :departments do |t|
      t.attachment :pdf
    end
    change_table :institutes do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :departments, :pdf
    drop_attached_file :institutes, :pdf
  end
end