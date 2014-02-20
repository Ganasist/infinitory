class ConfirmationsController < Devise::ConfirmationsController
	
	def new
    super
  end

  def create
    super
  end

  private
	  def after_confirmation_path_for(resource_name, resource)
	    # sign_in(resource_name, resource)
	    # user_path(resource)
	    # root_path
	    'www.infinitory.com'
	  end
end