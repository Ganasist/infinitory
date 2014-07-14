class DevicePolicy
  attr_reader :user, :device

  def initialize(user, device)
    @user = user
    @device = device
  end

  def show?
    user.lab == device.lab
  end

  def user_index?
  	current_user == User.find(params[:user_id])
  end

  def lab_index?
  	
  end

  def update?
    user.admin? or not post.published?
  end

end