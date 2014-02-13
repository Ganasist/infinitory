class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  before_action :set_institute, only: [:index, :new, :create, :update, :destroy]
  before_action :authenticate_user!
  
  def index
    if params[:term].present?
      @departments = @institute.departments
      render json: @departments.map { |x| "#{x.name} @ #{x.institute.name}"}
    else
      @departments = Department.where(institute_id: @institute)
    end
  end

  def show
    @labs = Lab.where(department_id: params[:id])
  end

  def new
    @department = Department.new
  end

  def edit
    @institute = @department.institute
  end

  def create
    @department = @institute.departments.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to institute_department_path(@institute, @department), 
                      notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to institute_department_path(@institute, @department), 
                      notice: 'Department was successfully updated.' }
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
      format.html { redirect_to institute_departments_path(@institute) }
      format.json { head :no_content }
    end
  end

  private
    def set_institute
      @institute = Institute.friendly.find(params[:institute_id])
    end

    def set_department
      @department = Department.find(params[:id])
    end

    def department_params
      params.require(:department).permit(:name, :email, :address, :room, :url, :acronym, :institute,
                                         :linkedin_url, :xing_url, :twitter_url, :facebook_url, :google_plus_url,
                                         :icon, :delete_icon, :icon_remote_url, :lock_version)
    end
end
