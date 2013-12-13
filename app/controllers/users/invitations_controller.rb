class Users::InvitationsController < Devise::InvitationsController
  def create
  	super
  end

  def edit
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