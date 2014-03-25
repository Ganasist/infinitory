class SessionsController < Devise::SessionsController

  # before_filter :check_user_confirmation, only: :create

private

  # def check_user_confirmation
  #   user = User.find_by_email(params[:email])
  #   redirect_to new_confirmation_path(:user) unless user && user.confirmed?
  # end
end