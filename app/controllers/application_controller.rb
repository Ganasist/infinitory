class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :role,
                                                            :institute_name, :department_name,
                                                            :password, :password_confirmation, 
                                                            :current_password) }

    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }
  end

end