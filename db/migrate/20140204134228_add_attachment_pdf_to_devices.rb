class AddAttachmentPdfToDevices < ActiveRecord::Migration
  def self.up
    change_table :devices do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :devices, :pdf
  end
end
