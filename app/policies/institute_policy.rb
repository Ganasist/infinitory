class InstitutePolicy < ApplicationPolicy
	attr_reader :user, :institute

  def initialize(user, institute)
    @user = user
    @institute = institute
  end

  def new?
  	user.super_admin?
  end

  def create?
  	new?
  end

  def show?
  	user.institute == institute || new?
  end

  def edit?
  	show? and user.gl?
  end

  def update?
  	edit?
  end

  def lab_indexes?
    user.institute == institute || new? 
  end
end