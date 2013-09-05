class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
  end

  def show
  end

  def edit
  end

  def update
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:email, :first_name, :last_name,
      														:group_leader_id, :department_id, :institute_id, :approved)
    end
end
