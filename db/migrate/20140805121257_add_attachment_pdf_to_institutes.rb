class AddAttachmentPdfToInstitutes < ActiveRecord::Migration
  def self.up
    change_table :institutes do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :institutes, :pdf
  end
end