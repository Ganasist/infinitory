class RegistrationsController < Devise::RegistrationsController

  protected
  	
  	def update_resource(resource, params)
	    resource.update_with_password(params)
	   	if resource.save
		    RequestMailsWorker.perform_async(resource.id)
		  end
	  end

    def after_update_path_for(resource)
      user_path(resource)
    end

	  def after_confirmation_path_for(resource_name, resource)
	    redirect_to new_user_session_path
	  end
end