class RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      lab_user_path(current_user.lab, resource)
    end
end