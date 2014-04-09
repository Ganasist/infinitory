class Collaboration < ActiveRecord::Base
	belongs_to :lab
	belongs_to :collaborator, class_name: 'Lab'

	# validates_associated :lab, :collaborator
	validates_presence_of :lab, :collaborator
	validates_uniqueness_of :lab_id, scope: :collaborator_id, message: "You are already collaborating with that lab!"

	def lab_email
    lab.try(:email)
  end
end
