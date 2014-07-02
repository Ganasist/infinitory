class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :check_members_and_collaborators!, only: :show
  before_action :block_outsiders!, except: :show

  def index
    @institute = Institute.find(params[:institute_id])
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
    @gl = User.where(lab_id: @lab, role: 'group_leader').first
    @users = @lab.users.includes(:sash)
    @department = @lab.department
    @institute = @lab.institute
    @notifications = @lab.comments.recent.page(params[:page]).per(16)

    data_table = GoogleVisualr::DataTable.new
    data_table.new_column("number", "Activity" )
    data_table.add_rows(60)
    (0..(@lab.sparkline_points.length - 1)).each do |i|
      data_table.set_cell(i,0,@lab.sparkline_points[i])
    end
    opts   = { width: 525, height: 60, showAxisLines: false,  showValueLabels: true, labelPosition: 'none' }
    @sparkline_chart = GoogleVisualr::Image::SparkLine.new(data_table, opts)

    data_table_lab = GoogleVisualr::DataTable.new
    data_table_lab.new_column('string', 'Name')
    data_table_lab.new_column('number', 'Devices')
    data_table_lab.new_column('number', 'Reagents')
    data_table_lab.new_column('number', 'pts/day')
    data_table_lab.new_column('number', 'Total points')
    data_table_lab.add_rows(@users.map { |u|[u.fullname,
                                             u.cached_device_count,
                                             u.cached_reagent_count,
                                             u.cached_daily_points,
                                             u.cached_total_points] })    
    @chart_lab = GoogleVisualr::Interactive::BubbleChart.new(data_table_lab, lab_scatter_options)

    # data_table_reagents = GoogleVisualr::DataTable.new
    # data_table_reagents.new_column('string', 'Category')
    # data_table_reagents.new_column('number', 'Relative amount')
    # data_table_reagents.add_rows(@lab.reagent_categories.length)
    # @lab.reagent_categories.each_with_index do |val, index| 
    #   data_table_reagents.set_cell(index, 0, "#{val}".humanize)
    #   data_table_reagents.set_cell(index, 1, @lab.reagents_category_count("#{val}"))
    # end
    # @chart_reagents = GoogleVisualr::Interactive::PieChart.new(data_table_reagents, pie_options)
  
    # data_table_devices = GoogleVisualr::DataTable.new
    # data_table_devices.new_column('string', 'Category')
    # data_table_devices.new_column('number', 'Relative amount')
    # data_table_devices.add_rows(@lab.device_categories.length)
    # @lab.device_categories.each_with_index do |val, index| 
    #   data_table_devices.set_cell(index, 0, "#{val}".humanize)
    #   data_table_devices.set_cell(index, 1, @lab.devices_category_count("#{val}"))
    # end
    # @chart_devices = GoogleVisualr::Interactive::PieChart.new(data_table_devices, pie_options)
  end

  def new
    @lab = Lab.new
  end

  def edit
  end

  def create
    if lab_params[:institute_id].present?
      @institute = Institute.find(lab_params)
      @lab = @institute.lab.new(lab_params)
    else
      @lab = Lab.new(lab_params)
    end
    
    respond_to do |format|
      if @lab.save
        format.html { redirect_to @lab }
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
        format.html { redirect_to @lab }
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
    def check_members_and_collaborators!
      unless (current_user.lab == Lab.find(params[:id])) || Lab.where(id: current_user.lab.inverse_collaborations.pluck(:lab_id)).include?(Lab.find(params[:id]))
        redirect_to current_user
        flash[:alert] = 'You cannot access that lab'
      end
    end

    def block_outsiders!
      unless (current_user.lab == Lab.find(params[:id]))
        redirect_to current_user
        flash[:alert] = 'You cannot access that page'
      end      
    end

    def set_lab
      @lab = Lab.find(params[:id])
    end

    def lab_params
      params.require(:lab).permit(  :device_category_list, :reagent_category_list, :email, :room, :lab_id, :department_id, :institute_id, 
                                    :ajax_section, :linkedin_url, :xing_url, :twitter_url, 
                                    :facebook_url, :department, :institute,
                                    :url, :icon, :delete_icon, :icon_remote_url)
    end
end
