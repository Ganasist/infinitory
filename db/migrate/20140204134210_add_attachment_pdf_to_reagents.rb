class AddAttachmentPdfToReagents < ActiveRecord::Migration
  def self.up
    change_table :reagents do |t|
      t.attachment :pdf
    end
  end

  def self.down
    drop_attached_file :reagents, :pdf
  end
end
