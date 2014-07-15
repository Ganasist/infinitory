class LabPolicy < ApplicationPolicy
  attr_reader :user, :lab

  def initialize(user, lab)
    @user = user
    @lab = lab
  end

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

  def item_indexes?
    user.lab == lab
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