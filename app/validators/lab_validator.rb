class LabValidator < ActiveModel::Validator
  def validate(lab)
    unless lab.one_gl == 1
      lab.errors[:gl] << 'Each lab must have 1 group leader!'
    end
  end
end