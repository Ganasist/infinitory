class AddPaperclipAttributesToModels < ActiveRecord::Migration
  def change
  	add_attachment :institutes, :icon
  	add_attachment :departments, :icon
  	add_attachment :labs, :icon
  	add_attachment :devices, :icon
  	add_attachment :reagents, :icon
  end
end
