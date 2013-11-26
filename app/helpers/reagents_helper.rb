module ReagentsHelper

  def expiring?(reagent)
    (reagent.expiration - Date.today).to_i < 30
  end

  def low?
  	
  end

  def almost_empty?
  	
  end
end
