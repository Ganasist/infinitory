class UsersController < ApplicationController
  before_action :set_user, only: [:show, :approve, :retire, :reject]
  before_action :set_lab, only: [:retire, :reject, :approve]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    @lab = Lab.find(params[:lab_id])
    authorize @lab, :user_indexes?
    @users = @lab.users
                 .includes(:sash)
                 .where(approved: true)
                 .order('joined ASC')
    @approvals = @lab.users.where(approved: false)
  end

  def show
    if request.path != user_path(@user)
      redirect_to @user, status: :moved_permanently
    end
    authorize @user    
    @chart = GoogleSparkliner.new(@user, 420).draw
    @activities = PublicActivity::Activity.includes(:trackable).where(owner_id: @user.id)
                                                               .group("activities.id")
                                                               .page(params[:activities])
                                                               .per(10)
                                                               .reverse_order
    @comments = @user.comments
                     .recent
                     .page(params[:comments])
                     .per(10)
  end

  def approve
    authorize @user
    @user.approved = true
    @user.joined = Time.now
    if @user.save
      flash[:notice] = "#{ @user.fullname } has joined your lab"
      @lab.comments.create(comment: "#{ @user.fullname } has joined the lab")
      if !@user.confirmed?
        ConfirmationMailsWorker.perform_async(@user.id)
      else
        UserMailer.delay(retry: false).welcome_email(@user.id, current_user.lab_id)
      end
    else
      flash[:alert] = "#{ @user.fullname } couldn't be approved..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  def reject
    authorize @user
    @user.reject
    if @user.save
      flash[:notice] = "#{ @user.fullname } has been rejected."
      UserMailer.delay(retry: false).rejection_email(@user.id, @lab.id)
    else
      flash[:alert] = "#{ @user.fullname } couldn't be rejected..."
    end
    redirect_to lab_users_path(current_user.lab)
  end

  def retire
    authorize @user
    @user.retire
    if @user.save
      flash[:notice] = "#{ @user.fullname } has been retired."
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
        flash[:alert] = "User wasn't found."
        redirect_to current_user
      else
        flash[:alert] = "You need to sign in or sign up before continuing."
        redirect_to root_url
      end
    end

    def set_user
      @user = User.find(params[:id])
    end

    def set_lab
      @lab = current_user.lab
    end
end
