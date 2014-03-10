class Collaboration < ActiveRecord::Base
	belongs_to :lab
	belongs_to :collaborator, class_name: 'Lab'
end
