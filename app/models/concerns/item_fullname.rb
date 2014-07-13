# Included in Device, Reagent
module ItemFullname
	extend ActiveSupport::Concern

	def fullname
   if self.uid.present? && self.location.present?
       "#{self.name}-#{self.uid} (#{self.location})"
    elsif self.uid.present? && !self.location.present?
        "#{self.name}-#{self.uid}"
    elsif !self.uid.present? && self.location.present?
      "#{self.name} (#{self.location})"
    elsif !self.uid.present? && !self.location.present?
      "#{self.name}"
  	end
  end

end