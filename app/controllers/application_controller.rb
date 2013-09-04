class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authenticate_user!, except: [:index, :show]
  # before_filter :configure_permitted_parameters, if: :devise_controller?

  # before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  # def configure_permitted_parameters
  #   devise_parameter_sanitizer.for(:sign_up) << :username
  # end

    # def devise_parameter_sanitizer
    #   if resource_class == User
    #     User::ParameterSanitizer.new(User, :user, params)
    #   elsif resource_class == GroupLeader
    #     GroupLeader::ParameterSanitizer.new(GroupLeader, :group_leader, params)
    #   else  
    #     super
    #   end
    # end

end