module ReagentsHelper

  def expiring?(reagent)
  	unless reagent.expiration.nil?
	    (reagent.expiration - Date.today).to_i < 30
	  end
  end

  def low?(reagent)
  	unless reagent.expiration.nil?
	  	reagent.remaining.between?(11, 25)
	  end
  end

  def almost_empty?(reagent)
  	unless reagent.expiration.nil?
	  	reagent.remaining.between?(0, 10)
	  end
  end
end


