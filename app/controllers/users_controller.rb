class UsersController < ApplicationController
  before_action :set_user, only: [:show, :activate, :retire, :reject]
  before_action :set_lab, only: [:retire, :reject]

  def index    
    @lab = Lab.friendly.find(params[:lab_id])
    @users = User.where(lab_id: @lab, approved: true).order(:role, :created_at)

    @approval = User.where(lab_id: @lab, approved: false).count
    if @approval > 0 && current_user.gl_lm?
      @approvals = User.where(lab_id: @lab, approved: false)
      @users = User.where(lab_id: @lab, approved: true).order(:role, :created_at)
    end
  end

  def show
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end

    @institute = @user.institute
    @department = @user.department
  	@lab = @user.lab
  end

  def activate
    @user.approve
    if @user.save
      flash[:notice] = "#{ @user.fullname } has joined your lab #{ undo_link }"
      if !@user.confirmed?
        ConfirmationMailsWorker.perform_async(@user.id)
      else
        WelcomeMailsWorker.perform_async(@user.id)
      end
    else
      flash[:alert] = "#{ @user.fullname } couldn't be added..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  def reject
    @user.reject
    if @user.save
      flash[:notice] = "#{ @user.fullname } has been rejected. #{ undo_link }"
      RejectMailsWorker.perform_async(@user.id, @lab.id)      
    else
      flash[:alert] = "#{ @user.fullname } couldn't be rejected..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  def retire
    @user.retire
    if @user.save
      flash[:notice] = "#{ @user.fullname } has been retired. #{ undo_link }"
      RetireMailsWorker.perform_async(@user.id, @lab.id)   
    else
      flash[:alert] = "#{ @user.fullname } couldn't be retired..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.friendly.find(params[:id])
    end

    def set_lab
      @lab = current_user.lab
    end

    def undo_link
      view_context.link_to("UNDO", revert_version_path(@user.versions.last), 
                            method: :post, class: "btn-large")
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    # def user_params
    #   params.require(:lab).permit(:email, :first_name, :last_name,
    #   														:group_leader_id, :department_id, :institute_id, :approved)
    # end
end
