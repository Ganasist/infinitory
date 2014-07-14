class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  include Pundit

  # protect_from_forgery with: :exception
  protect_from_forgery with: :null_session

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :orphans, except: [:edit, :update, :destroy]

  # rescue_from ActiveRecord::StaleObjectError, with: :stale_record
  # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  # rescue_from ActiveRecord::RecordNotUnique, with: :record_not_unique

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

    def user_not_authorized(exception)
      policy_name = exception.policy.class.to_s.underscore

      flash[:error] = I18n.t "pundit.#{policy_name}.#{exception.query}",
                            default: 'You cannot access that page.'
      redirect_to(current_user)
    end

    helper_method :pie_options
    def pie_options
      { width: '100%', height: '100%', pieSliceText: 'none', fontSize: 12,
        legend: { position: 'labeled', alignment: 'center' }, 
        chartArea: { width: '92%', height: '92%' },
        tooltip: { textStyle: { fontSize: 15 }, text: 'value' } }
    end

    helper_method :fullname
    def fullname(item)
      if item.uid.present?
        "#{ item.name }-#{ item.uid }"
      else
        "#{ item.name }"
      end
    end

    helper_method :send_destroy_comment
    def send_destroy_comment(item, action)      
      if item.location.present?
        item.users.each do |u|
          u.comments.create(comment: "#{ fullname(item) } (#{ item.location }) was #{ action } by #{ current_user.fullname }")
        end
        item.lab.comments.create(comment: "#{ fullname(item) } (#{ item.location }) was #{ action } by #{ current_user.fullname }")
      else
        item.users.each do |u|
          u.comments.create(comment: "#{ fullname(item) } was #{ action } by #{ current_user.fullname }")
        end
        item.lab.comments.create(comment: "#{ fullname(item) } was #{ action } by #{ current_user.fullname }")
      end
    end

    def after_sign_in_path_for(resource)
      user_path(current_user)
    end

    def after_update_path_for(resource)
      user_path(current_user)
    end

    def orphans
      if user_signed_in?
        if current_user.approved? && !current_user.confirmed?
          redirect_to edit_user_registration_path
          flash[:alert] = "Please sign-out and confirm your email address"
        elsif !current_user.approved?
          redirect_to edit_user_registration_path
          flash[:alert] = "You currently don't belong to a lab"
          if current_user.save && !current_user.lab.blank?
            flash[:success] = "Please wait for approval to join the #{current_user.gl.fullname} lab"
          end
        end
      end
    end

    def configure_permitted_parameters
      devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:role, :email, :lab_email, :terms,
                                                              :institute, :department,
                                                              :password, :approved, :password_confirmation) }

      devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email, :password) }

      devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :role, :approved,
                                                                     :lab_email, :department_id, :institute_name,
                                                                     :linkedin_url, :xing_url, :twitter_url, :facebook_url,
                                                                     :password, :password_confirmation,
                                                                     :pdf, :delete_pdf, :pdf_remote_url,
                                                                     :icon, :delete_icon, :icon_remote_url) }
      
      devise_parameter_sanitizer.for(:accept_invitation) { |u| u.permit(:email, :role, :invitation_token,
                                                                        :institute_name, :lab_email,
                                                                        :password, :password_confirmation)}
    end

end