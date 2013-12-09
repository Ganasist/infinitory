class Users::InvitationsController < Devise::InvitationsController
  def create
  	# User.invite!({:email => params[:user_email]}, current_user)
    flash[:alert] = "This is a #{current_user.fullname}"
  	super
  end

  def edit
  	flash[:alert] = "This is a test"
  	super
  end

  def update
    if params[:role] == "group_leader"
      self.approved = true
      super
    else
      super
    end
  end
end