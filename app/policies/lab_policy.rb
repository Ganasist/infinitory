class LabPolicy < ApplicationPolicy
  attr_reader :user, :lab

  def initialize(user, lab)
    @user = user
    @lab = lab
  end

  def new?
  	user.super_admin?
  end

  def create?
    new?  
  end

  def show?
    user.lab == lab ||
    Lab.where(id: user.lab.inverse_collaborations.pluck(:lab_id)).include?(lab)
  end

  def edit?
  	user.gl_lm? and (user.lab == lab)
  end

  def own_items?
    user.lab == lab
  end

  def user_indexes?
    own_items?
  end

  def update?
    edit?
  end

  def destroy?
    user.gl? and (user.lab == lab)
  end
end