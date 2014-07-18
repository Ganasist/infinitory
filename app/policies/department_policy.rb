class DepartmentPolicy < ApplicationPolicy
	attr_reader :user, :department

  def initialize(user, department)
    @user = user
    @department = department
  end

  def new?
  	user.super_admin?
  end

  def create?
  	new?
  end

  def show?
  	user.department == department
  end

  def edit?
  	show? and user.gl?
  end

  def update?
  	edit?
  end

  def lab_indexes?
    user.department == department    
  end
end