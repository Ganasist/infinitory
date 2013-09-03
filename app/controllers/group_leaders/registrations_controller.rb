class GroupLeaders::RegistrationsController < Devise::RegistrationsController

	# before_filter :configure_permitted_parameters

	
	# protected
	# 	def configure_permitted_parameters
	#     devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email, :department_id, :institute_id,
	#     																												:password, :password_confirmation) }
	#   end 
end