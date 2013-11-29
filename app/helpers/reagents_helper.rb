module ReagentsHelper

  def expiring?(reagent)
    (reagent.expiration - Date.today).to_i < 30
  end

  def low?(reagent)
  	reagent.remaining.between?(10, 25)
  end

  def almost_empty?(reagent)
  	reagent.remaining.between?(0, 10)
  end
end


