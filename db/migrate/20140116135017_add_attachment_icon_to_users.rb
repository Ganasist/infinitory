class AddAttachmentIconToUsers < ActiveRecord::Migration
  def change
    add_attachment :users, :icon
  end
end
