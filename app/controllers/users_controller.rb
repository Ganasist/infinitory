class UsersController < ApplicationController
  before_action :set_user, only: [:show]

  def index
    @users = User.where(lab_id: params[:lab_id]).order(:role, :created_at)
    @lab = Lab.find(params[:lab_id])
  end

  def show
  	@lab = Lab.where(params[:lab_id])
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def user_params
    #   params.require(:lab).permit(:email, :first_name, :last_name,
    #   														:group_leader_id, :department_id, :institute_id, :approved)
    # end
end