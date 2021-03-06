class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :set_institute, only: [:index, :new, :create, :update, :destroy]
  before_action :authenticate_user!
  after_action :verify_authorized
  
  def index
    if params[:term].present?
      @departments = @institute.departments
      render json: @departments.map { |d| "#{d.name} @ #{d.institute.name}"}
    else
      @departments = Department.where(institute_id: @institute)
    end
  end

  def show
    authorize @department
    @labs = Lab.where(department_id: params[:id])
  end

  def new
    @department = Department.new
    authorize @department
  end

  def edit
    authorize @department
    @institute = @department.institute
  end

  def create
    @department = @institute.departments.new(department_params)
    authorize @department
    respond_to do |format|
      if @department.save
        if current_user.department.nil?
          current_user.department = @department
        end
        format.html { redirect_to institute_department_path(@institute, @department) }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @department
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to institute_department_path(@institute, @department) }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @department.destroy
    respond_to do |format|
      format.html { redirect_to institute_departments_path(@institute), notice: 'Department removed.' }
      format.json { head :no_content }
    end
  end

  private
    rescue_from ActiveRecord::RecordNotFound do |exception|
      if user_signed_in?
        flash[:alert] = "Department wasn't found."
        redirect_to current_user
      else
        flash[:alert] = 'You need to sign in or sign up before continuing.'
        redirect_to root_url
      end
    end

    def set_institute
      @institute = Institute.find(params[:institute_id])
    end

    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name, :email, :address, :room, :url, :acronym, :institute,
                                         :linkedin_url, :xing_url, :twitter_url, :facebook_url,
                                         :pdf, :delete_pdf, :pdf_remote_url,
                                         :icon, :delete_icon, :icon_remote_url)
    end
end
