class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  # before_action :authenticate_user! 
  
  def index
    if params[:term].present?
      @departments = @institute.departments
      render json: @departments.map { |x| "#{x.name} @ #{x.institute.name}"}
    else
      @institute = Institute.friendly.find(params[:institute_id])
      @departments = Department.where(institute_id: @institute)
    end
  end

  def show
    @labs = Lab.includes(:users).where(department_id: params[:id])
    gon.rabl "app/views/departments/show.json.rabl", as: "department"
  end

  def new
    @institute = Institute.friendly.find(params[:institute_id])
    @department = Department.new
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @institute = Institute.friendly.find(params[:institute_id])   
    @department = @institute.departments.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to department_path(@department), 
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
        format.html { redirect_to department_path(@department), 
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
      format.html { redirect_to departments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.require(:department).permit(:name, :address, :room, :url, :acronym)
    end
end
