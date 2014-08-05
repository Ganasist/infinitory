class DropAttachmentsFromInstitutes < ActiveRecord::Migration
  def change
  	drop_attached_file :institutes, :pdf
  end
end
