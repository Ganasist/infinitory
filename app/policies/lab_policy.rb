class LabPolicy < ApplicationPolicy
  attr_reader :user, :lab

  def initialize(user, lab)
    @user = user
    @lab = lab
  end

  # class Scope
  # 	attr_reader :user, :scope

  #   def initialize(user, scope, params_sort, params_direction)
  #     @user = user
  #     @scope = scope
  #   end

  #   def resolve
  #  	end
  # end

  def show?
    user.lab == lab
  end

  def new?
  	show?
  end

  def edit?
  	# user.gl_lm? and user.lab == lab
  end

  def own_item?
    show?
  end

  def create?
  	
  end

  def update?
    user.admin?
  end

  def destroy?
  	show?
  end
end