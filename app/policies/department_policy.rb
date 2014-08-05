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
  	user.institute == department.institute || new?
  end

  def edit?
  	(user.department == department) and user.gl? || new?
  end

  def update?
  	edit?
  end

  def lab_indexes?
    user.department == department || new? 
  end

  def destroy?
    new?
  end
end