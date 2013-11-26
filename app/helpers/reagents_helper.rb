module ReagentsHelper

  def expiring?(reagent)
    (reagent.expiration - Date.today).to_i < 30
  end
end
