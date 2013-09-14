class UsersController < ApplicationController
  before_action :set_user, only: [:show, :activate]

  def index
    if params[:tag]
      @users = User.tagged_with(params[:tag]).order(created_at: :desc)
      @approval = 0
    else      
      @users = User.where(lab_id: params[:lab_id], approved: true).order(:role, :created_at)
      @lab = Lab.find(params[:lab_id])    
      @approval = User.where(lab_id: params[:lab_id], approved: false).count
      
      if @approval > 0 && current_user.gl_lm?
        @approvals = User.where(lab_id: params[:lab_id], approved: false)
        @users = User.where(lab_id: params[:lab_id], approved: true).order(:role, :created_at)
      end
    end
  end

  def show
    @institute = @user.institute
    @department = @user.department
  	@lab = @user.lab
  end

  def activate
    @user.update_attributes(approved: true)
    redirect_to lab_users_path(current_user.lab)
  end

  def deactivate
    @user.update_attributes(approved: false)
    redirect_to lab_users_path(current_user.lab)
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
