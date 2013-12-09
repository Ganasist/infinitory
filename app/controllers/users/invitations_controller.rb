class Users::InvitationsController < Devise::InvitationsController
  def create
  	flash[:alert] = "This is a test #{current_user.fullname}"
  	super
  end

  def edit
  	flash[:alert] = "This is a test #{current_user.fullname}"
  	super
  end

  def update
    if params[:role] == "group_leader"
      redirect_to root_path
    else
      super
    end
  end
end