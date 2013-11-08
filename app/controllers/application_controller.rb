class ApplicationController < ActionController::Base

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :orphans, except: [:edit, :update, :destroy]

  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  protected

    def after_sign_in_path_for(resource)
      user_path(current_user)
    end

    # def after_update_path_for(resource)
    #   user_path(current_user)
    # end

    # def record_not_found
    #   redirect_to root_path
    #   flash[:alert] = "Resource does not exist!"
    # end

    def orphans
      if user_signed_in?
        if current_user.approved? && !current_user.confirmed?
          redirect_to edit_user_registration_path
          flash[:alert] = "Please confirm your email address"
        elsif !current_user.approved?
          redirect_to edit_user_registration_path
          flash[:alert] = "You currently don't belong to a lab"
          if current_user.save && current_user.lab_id != nil
            flash[:alert] = "Please wait for approval to join the #{current_user.lab.name} lab"
          end
        end
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:role, :email, :lab_id,
                                                              :institute_name, :password, 
                                                              :approved, :password_confirmation) }

      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }

      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, 
                                                                     :room, :role, :approved, 
                                                                     :lab_id, :department_id, :institute_id, 
                                                                     :institute_name, :password, 
                                                                     :password_confirmation, :current_password, 
                                                                     :icon, :remote_icon_url, :remove_icon, 
                                                                     :icon_cache) }
    end

end