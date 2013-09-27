class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :set_lab, except: [:show, :edit, :update, :destroy]

  # GET /reagents
  # GET /reagents.json
  def index
    @lab = Lab.friendly.find(params[:lab_id])
    @reagents = Reagent.where(lab_id: @lab)
  end

  # GET /reagents/1
  # GET /reagents/1.json
  def show
    @lab = @reagent.lab 
  end

  # GET /reagents/new
  def new
    @reagent = Reagent.new
  end

  # GET /reagents/1/edit
  def edit
  end

  # POST /reagents
  # POST /reagents.json
  def create
    @lab = Lab.friendly.find(params[:lab_id])
    @reagent = @lab.reagents.new(reagent_params)    

    respond_to do |format|
      if @reagent.save
        format.html { redirect_to @reagent, notice: 'Reagent was successfully created.' }
        format.json { render action: 'show', status: :created, location: @reagent }
      else
        format.html { render action: 'new' }
        format.json { render json: @reagent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reagents/1
  # PATCH/PUT /reagents/1.json
  def update
    respond_to do |format|
      if @reagent.update(reagent_params)
        format.html { redirect_to @reagent, notice: 'Reagent was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reagent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reagents/1
  # DELETE /reagents/1.json
  def destroy
    @lab = @reagent.lab
    @reagent.destroy
    respond_to do |format|
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_lab
      @lab = Lab.friendly.find(params[:lab_id])   
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def reagent_params
      params.require(:reagent).permit(:lab_id, :name, :category, :owner, :location, :price, :serial, 
                                      :quantity, :properties, :description, :expiration)
    end
end
