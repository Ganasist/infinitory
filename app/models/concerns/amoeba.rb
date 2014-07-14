# Included in Device, Reagent
module Amoeba
	extend ActiveSupport::Concern
	extend ActiveModel::Naming

  included do
    amoeba do
      enable
      customize(lambda { |original, clone|
        clone.uid        = SecureRandom.hex(2)
        clone.activities = []

        if self.class == "Device"
          clone.bookings   = []
        end

        if self.class == "Reagent"
        	clone.remaining  = 100
        	if original.expiration.past?
        		clone.expiration = Date.today + 5.years
        	end
        end

        if original.icon.present?
          clone.icon = original.icon
        end
        if original.pdf.present?
          clone.pdf = original.pdf
        end
      })
    end
  end
end