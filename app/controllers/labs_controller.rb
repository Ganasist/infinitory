class LabsController < ApplicationController
  before_action :set_lab, only: [:show, :edit, :update, :destroy]

  # GET /labs
  # GET /labs.json
  def index
    @institute = Institute.friendly.find(params[:institute_id])
    @labs = Lab.where(institute_id: @institute)

    if params[:department_id].present?
      @department = Department.find(params[:department_id])
      @labs = Lab.where(institute_id: @institute, department_id: @department)
    end
  end

  # GET /labs/1
  # GET /labs/1.json
  def show
  end

  # GET /labs/new
  def new
    @lab = Lab.new
  end

  # GET /labs/1/edit
  def edit
  end

  # POST /labs
  # POST /labs.json
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

  # PATCH/PUT /labs/1
  # PATCH/PUT /labs/1.json
  def update
    respond_to do |format|
      if @lab.update(lab_params)
        format.html { redirect_to @lab, notice: 'Lab was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @lab.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /labs/1
  # DELETE /labs/1.json
  def destroy
    @lab.destroy
    respond_to do |format|
      format.html { redirect_to root_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lab
      @lab = Lab.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lab_params
      params.require(:lab).permit(:department_id, :institute_id, :group_leader, :email)
    end
end
