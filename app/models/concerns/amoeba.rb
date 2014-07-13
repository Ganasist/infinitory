# Included in Device, Reagent
module Amoeba
	extend ActiveSupport::Concern

	# amoeba do
 #    enable
 #    customize(lambda { |original, clone|
 #      clone.uid        = SecureRandom.hex(2)
 #      clone.activities = []

 #      if original.class.name == "Device"
	#       clone.bookings   = []
	#     end

	#     if orignal.class.name == "Reagent"
	#     	clone.remaining  = 100
	#     	if original.expiration.past?
	#     		clone.expiration = Date.today + 5.years
	#     	end
	#     end

 #      if original.icon.present?
 #        clone.icon = original.icon
 #      end
 #      if original.pdf.present?
 #        clone.pdf = original.pdf
 #      end
 #    })
 #  end

  # amoeba do
  #   enable
  #   customize(lambda { |original_reagent, new_reagent|
  #   	new_reagent.uid        = SecureRandom.hex(2)
  #   	new_reagent.activities = []

  #   	new_reagent.remaining  = 100
  #     if original_reagent.expiration.past?
  #       new_reagent.expiration = Date.today + 5.years
  #     end

  #     if original_reagent.icon.present?
  #     	new_reagent.icon = original_reagent.icon
  #    	end
  #     if original_reagent.pdf.present?
  #       new_reagent.pdf = original_reagent.pdf
  #     end
  #   })
  # end

end