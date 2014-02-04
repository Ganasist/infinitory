class AddAttachmentPdfToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :users, :pdf
  end
end
