class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  def after_sign_in_path_for(resource)
   lab_user_path(current_user.lab, current_user)
  end

  def after_update_path_for(resource)
    lab_user_path(current_user.lab, current_user)
  end


  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :role, :institute_name, :department_name, :password) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }



    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email,
                                                                   :password, :password_confirmation, 
                                                                   :current_password) }
  end

end