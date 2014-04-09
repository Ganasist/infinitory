class Collaboration < ActiveRecord::Base
	belongs_to :lab
	belongs_to :collaborator, class_name: 'Lab'

	validates_presence_of :lab_id
	validates_uniqueness_of :lab_id, scope: :collaborator_id, message: "You are already collaborating with that lab!"

  # validates :lab_email, presence: true, inclusion: { in: Lab.all.pluck(:email), message: 'There is no lab with that email address on Infinitory' }

	validates_with CollaborationValidator

	def lab_email
    lab.try(:email)
  end
end
