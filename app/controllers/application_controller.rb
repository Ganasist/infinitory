class ApplicationController < ActionController::Base
  include PublicActivity::StoreController

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :orphans, except: [:edit, :update, :destroy]

  # rescue_from ActiveRecord::StaleObjectError, with: :stale_record
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  protected

    def pie_options
      {width: 400, height: '100%', pieSliceText: 'none', fontSize: 12,
       legend: {position: 'labeled', alignment: 'center'}, 
       chartArea: {width: "92%", height: "92%"},
       tooltip: {textStyle: {fontSize: 15}, text: 'value'}}
    end
    helper_method :pie_options

    def lab_scatter_options
      {width: 500, height: 500,
       chartArea: {width: "80%", height: "80%"},
       legend: { position: 'none'},
       colorAxis: { colors: ['white', 'blue']},
       hAxis: { title: 'Devices', logScale: false },
       vAxis: { title: 'Reagents', logScale: false  },
       bubble: { textStyle: { :fontSize => 11 }}}
    end
    helper_method :lab_scatter_options

    def after_sign_in_path_for(resource)
      user_path(current_user)
    end

    # def after_update_path_for(resource)
    #   user_path(current_user)
    # end

    def orphans
      if user_signed_in?
        if current_user.approved? && !current_user.confirmed?
          redirect_to edit_user_registration_path
          flash[:alert] = "Please confirm your email address"
        elsif !current_user.approved?
          redirect_to edit_user_registration_path
          flash[:alert] = "You currently don't belong to a lab"
          if current_user.save && !current_user.lab.blank?
            flash[:alert] = "Please wait for approval to join the #{current_user.gl.fullname} lab"
          end
        end
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:role, :email, :lab_email,
                                                              :institute_name, :password, 
                                                              :approved, :password_confirmation) }

      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }

      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email,
                                                                     :role, :approved, :lab_email,
                                                                     :department_id, :institute_name, :password, 
                                                                     :password_confirmation, :current_password, 
                                                                     :icon, :remote_icon_url,
                                                                     :remove_icon, :icon_cache) }
      
      devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:email, :role, :invitation_token,
                                                                        :institute_name, :lab_email,
                                                                        :password, :password_confirmation)}
    end

end