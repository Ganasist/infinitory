class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_user!, except: :index

  def index
    @institute = Institute.friendly.find(params[:institute_id])
    @labs = @institute.labs

    if params[:department_id].present?
      @department = Department.find(params[:department_id])
      @labs = Lab.where(institute_id: @institute, department_id: @department)
    end
  end

  def show
    if request.path != lab_path(@lab)
      redirect_to @lab, status: :moved_permanently
    end
    @user = User.where(lab_id: @lab, role: "group_leader").first
    # @activities = PublicActivity::Activity.includes(:trackable, :owner).where(owner_id: @lab.user_ids).limit(25).order('created_at desc')
    @users = @lab.users.includes(:sash)
    @department = @lab.department
    @institute = @lab.institute
    @comments = @lab.comments.recent.limit(50)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Name')
    data_table.new_column('number', 'Devices')
    data_table.new_column('number', 'Reagents')
    data_table.new_column('number', "Today's points")
    data_table.new_column('number', 'Total points')
    data_table.add_rows(@users.map { |u|[u.fullname,
                                         u.device_count,
                                         u.reagent_count,
                                         u.cached_daily_scores,
                                         u.cached_total_points] })    
    @chart = GoogleVisualr::Interactive::BubbleChart.new(data_table, lab_scatter_options)
  end

  def new
    @lab = Lab.new
  end

  def edit
  end

  def create
    if lab_params[:institute_id].present?
      @institute = Institute.find(params[lab_params])
      @lab = @institute.lab.new(lab_params)
    else
      @lab = Lab.new(lab_params)
    end
    
    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab, notice: 'Lab was successfully created.' }
        format.json { render action: 'show', status: :created, location: @lab }
      else
        format.html { render action: 'new' }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { head :no_content }
        format.js
      else
        format.html { render action: 'edit' }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    def check_user!
      if current_user.lab != Lab.find(params[:id])
        redirect_to current_user
        flash[:alert] = "You cannot access that lab"
      end
    end

    def set_lab
      @lab = Lab.find(params[:id])
    end

    def lab_params
      params.require(:lab).permit(:email, :room, :lab_id, :department_id, :institute_id, 
                                  :department, :institute, :url, :icon, :delete_icon, :icon_remote_url)
    end
end
