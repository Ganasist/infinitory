class DevicePolicy < ApplicationPolicy
  attr_reader :user, :device

  def initialize(user, device)
    @user = user
    @device = device
  end

  def show?
    user.lab == device.lab
  end

  def edit?
  	show?
  end

  def clone?
  	show?
  end

  def update?
    show?
  end

  def destroy?
  	show?
  end

  def bookings_index?
    (user.lab == device.lab) and device.bookable? 
  end
end