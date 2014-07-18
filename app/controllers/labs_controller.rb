class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  # before_action :check_members_and_collaborators!, only: :show
  after_action :verify_authorized

  def index
    @institute = Institute.find(params[:institute_id])
    @labs = @institute.labs
    authorize @institute, :lab_indexes?

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
    authorize @lab
    @notifications = @lab.comments.recent.page(params[:page]).per(16)

    @sparkline_chart = GoogleSparkliner.new(@lab, 525).draw    
    @chart_lab = GoogleBubbler.new(@users).draw
  end

  def new
    @lab = Lab.new
  end

  def edit
    authorize @lab
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
    # def check_members_and_collaborators!
    #   unless (current_user.lab == Lab.find(params[:id])) || Lab.where(id: current_user.lab.inverse_collaborations.pluck(:lab_id)).include?(Lab.find(params[:id]))
    #     redirect_to current_user
    #     flash[:alert] = 'You cannot access that lab'
    #   end
    # end

    def set_lab
      @lab = Lab.find(params[:id])
    end

    def lab_params
      params.require(:lab).permit(  :device_category_list, :reagent_category_list, :email, :room,
                                    :lab_id, :department_id, :institute_id, 
                                    :ajax_section, :linkedin_url, :xing_url, :twitter_url, 
                                    :url, :facebook_url, :department, :building, :institute,
                                    :pdf, :delete_pdf, :pdf_remote_url,
                                    :icon, :delete_icon, :icon_remote_url)
    end
end
