class ReagentPolicy < ApplicationPolicy

	attr_reader :user, :reagent

  def initialize(user, reagent)
    @user = user
    @reagent = reagent
  end

  def show?
  	user.lab == reagent.lab  	
  end

  def new?
  	user == reagent
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