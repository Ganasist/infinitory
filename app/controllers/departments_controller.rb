class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :edit, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    if params[:term].present?
      # @institute = Institute.where(name: params[:term])
      # render json: @institute.departments.map(&:name)
      # @tests = Department.all(include: [:institute]).map(&:test)
    else
      @institute = Institute.friendly.find(params[:institute_id])
      @departments = Department.where(institute_id: @institute)  
      @circles_json = @departments.to_gmaps4rails do |department|
                         {lng: "#{department.longitude}",
                          lat: "#{department.latitude}",
                          radius: 20,
                          strokeColor: "#FF0000",
                          strokeOpacity: 0.8,
                          strokeWeight: 1,
                          fillColor: "#000",
                          fillOpacity: 0.35}
         end
      @mapped = @departments.to_gmaps4rails do |department, marker|
        marker.infowindow "<h4>#{department.name}<h4>
                            <h5>Labs: #{department.labs.count}</h5>"
      end
    end
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
    @institute = Institute.friendly.find(params[:institute_id])
    @mapped = @department.to_gmaps4rails
  end

  # GET /departments/new
  def new
    @institute = Institute.friendly.find(params[:institute_id])
    @department = Department.new
  end

  # GET /departments/1/edit
  def edit
    gon.push({
      longitude: @department.longitude,
      latitude: @department.latitude
    })
    @institute = Institute.friendly.find(params[:institute_id])
  end

  # POST /departments
  # POST /departments.json
  def create
    @institute = Institute.friendly.find(params[:institute_id])   
    @department = @institute.departments.new(department_params)

    respond_to do |format|
      if @department.save
        format.html { redirect_to institute_department_path(@department.institute, @department), 
                      notice: 'Department was successfully created.' }
        format.json { render action: 'show', status: :created, location: @department }
      else
        format.html { render action: 'new' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    @institute = Institute.friendly.find(params[:institute_id])    

    respond_to do |format|
      if @department.update(department_params)
        format.html { redirect_to institute_department_path(@department.institute, @department), 
                      notice: 'Department was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @department.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
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
      params.require(:department).permit(:name, :address, :url, :acronym)
    end
end
