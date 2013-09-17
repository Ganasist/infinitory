class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :configure_permitted_parameters, if: :devise_controller?
  

  def after_sign_in_path_for(resource)
   user_path(current_user)
  end

  def after_update_path_for(resource)
    user_path(current_user)
  end


  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:role, :email, :lab_id, :department_name, 
                                                              :institute_name, :password, :approved,
                                                              :password_confirmation) }

      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }

      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :icon, :tag_list, :lab_id,
                                                                     :description, :approved, :department_id, :institute_name,
                                                                     :password, :password_confirmation, :current_password, 
                                                                     :icon, :remote_icon_url, :remove_icon, :icon_cache) }
    end

end