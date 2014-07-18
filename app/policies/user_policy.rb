class UserPolicy < ApplicationPolicy
	attr_reader :current_user, :user

  def initialize(current_user, user)
    @user = user
    @current_user = current_user
  end

	def show?
  	current_user.lab == user.lab  	
  end

  def new?

  end

  def edit?
  	current_user == user
  end

  def create?
  	
  end

  def update?
  	current_user == user
  end

  def destroy?
  	current_user == user
  end

  def approve?
  	current_user.gl_lm? and current_user.lab == user.lab
  end

  def reject?
  	approve?
  end
   
  def retire?
  	approve?
  end

  def item_indexes?
    current_user == user
  end
end