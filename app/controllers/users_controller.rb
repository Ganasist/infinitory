class UsersController < ApplicationController
  before_action :set_user, only: [:show, :approve, :retire, :reject]
  before_action :set_lab, only: [:retire, :reject, :approve]
  before_action :authenticate_user!

  def index    
    @lab = Lab.find(params[:lab_id])
    @users = @lab.users.includes(:sash).where(approved: true).order("joined ASC")
    
    @approvals = @lab.users.where(approved: false)
  end

  def show
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
    @activities = PublicActivity::Activity.includes(:trackable).where(owner: @user).page(params[:activities]).per(10).reverse_order
    @notifications = @user.comments.recent.page(params[:notifications]).per(10)
  end

  def approve
    @user.approved = true
    @user.joined = Time.now
    if @user.save
      flash[:notice] = "#{ @user.fullname } has joined your lab #{ undo_link }"
      @lab.comments.create(comment: "#{ @user.fullname } joined the lab")
      if !@user.confirmed?
        ConfirmationMailsWorker.perform_async(@user.id)
      else
        UserMailer.delay(retry: false).welcome_email(@user.id, current_user.lab_id)
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
      UserMailer.delay(retry: false).rejection_email(@user.id, @lab.id)
    else
      flash[:alert] = "#{ @user.fullname } couldn't be rejected..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  def retire
    # @labtemp = @lab
    @user.retire
    if @user.save
      flash[:notice] = "#{ @user.fullname } has been retired. #{ undo_link }"
      @lab.comments.create(comment: "#{ @user.fullname } retired from the lab")
      UserMailer.delay(retry: false).retire_email(@user.id, @lab.id)
    else
      flash[:alert] = "#{ @user.fullname } couldn't be retired..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  private

    rescue_from ActiveRecord::RecordNotFound do |exception|
      if user_signed_in?
        flash[:alert] = "User #{ params[:id] } wasn't found."
        redirect_to current_user
      else
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to root_url
      end
    end

    def set_user
      @user = User.friendly.find(params[:id])
    end

    def set_lab
      @lab = current_user.lab
    end

    def undo_link
      view_context.link_to("UNDO", revert_version_path(@user.versions.last), 
                            method: :post, class: "btn btn-warning")
    end

    # def user_params
    #   params.require(:lab).permit(:email, :first_name, :last_name,
    #   														:group_leader_id, :department_id, :institute_id, :approved)
    # end
end
