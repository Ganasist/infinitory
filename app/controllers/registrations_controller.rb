class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      user_path(resource)
    end

	  def after_confirmation_path_for(resource_name, resource)
	    redirect_to new_user_session_path
	  end
end