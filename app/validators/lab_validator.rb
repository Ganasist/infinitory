class LabValidator < ActiveModel::Validator

	def initialize(lab)
		@lab = lab
	end

  def validate(record)
    unless lab.gl_count == 1
      record.errors[:name] << 'Each lab must have 1 group leader'
    end
  end
end