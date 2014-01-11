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
    @activities = PublicActivity::Activity.includes(:trackable, :owner).where(owner_id: @lab.user_ids).limit(25).order('created_at desc')
    @department = @lab.department
    @institute = @lab.institute
    @comments = @lab.comments.recent.limit(25)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'ID')
    data_table.new_column('number', 'Life Expectancy')
    data_table.new_column('number', 'Fertility Rate')
    data_table.new_column('string', 'Region')
    data_table.new_column('number', 'Population')
    data_table.add_rows( [
      ['CAN',    80.66,              1.67,      'North America',  33739900],
      ['DEU',    79.84,              1.36,      'Europe',         81902307],
      ['DNK',    78.6,               1.84,      'Europe',         5523095],
      ['EGY',    72.73,              2.78,      'Middle East',    79716203],
      ['GBR',    80.05,              2,         'Europe',         61801570],
      ['IRN',    72.49,              1.7,       'Middle East',    73137148],
      ['IRQ',    68.09,              4.77,      'Middle East',    31090763],
      ['ISR',    81.55,              2.96,      'Middle East',    7485600],
      ['RUS',    68.6,               1.54,      'Europe',         141850000],
      ['USA',    78.09,              2.05,      'North America',  307007000]
    ])
    
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
                                  :department, :institute, :url, :icon, :remove_icon, :remote_icon_url, :icon_cache)
    end
end
