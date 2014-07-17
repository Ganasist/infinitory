class UserPolicy < ApplicationPolicy
	attr_reader :current_user, :user

  def initialize(current_user, user)
    @user = user
    @current_user = current_user
  end

  def item_indexes?
    current_user == user
  end
end