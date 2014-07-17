class RegistrationsController < Devise::RegistrationsController
  
  after_action :verify_authorized, only: :edit

  def edit
    authorize @user  
  end

  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)

    # required for settings form to submit when password is left blank
    if account_update_params[:password].blank?
      account_update_params.delete("password")
      account_update_params.delete("password_confirmation")
    end

    @user = User.find(current_user.id)
    if @user.update_attributes(account_update_params)
      # Sign in the user bypassing validation in case his password changed
      sign_in @user, :bypass => true
      redirect_to after_update_path_for(@user)
    else
      render "edit"
    end
  end

  protected
    def after_update_path_for(resource)
      user_path(resource)
    end

	  def after_confirmation_path_for(resource_name, resource)
	    redirect_to new_user_session_path
	  end
end