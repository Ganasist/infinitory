class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # before_filter :authenticate_user!, except: [:index, :show]
  # before_filter :authenticate_group_leader!, :only => [:new, :edit, :create, :destroy]


  protected
 
    def devise_parameter_sanitizer
      if resource_class == User
        User::ParameterSanitizer.new(User, :user, params)
      elsif resource_class == GroupLeader
        GroupLeader::ParameterSanitizer.new(GroupLeader, :group_leader, params)
      else  
        super
      end
    end

end