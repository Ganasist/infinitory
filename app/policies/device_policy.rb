class DevicePolicy < ApplicationPolicy
  attr_reader :user, :device

  def initialize(user, device)
    @user = user
    @device = device
  end

  class Scope
  	attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
    	scope.all
   	end
  end

  def show?
    user.lab == device.lab
  end

  def new?
  	user == device
  end

  def edit?
  	show?
  end

  def create?
  	
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
end