class ConfirmationsController < Devise::ConfirmationsController

  private

  def after_confirmation_path_for(resource)
    user_path(resource)
  end

end