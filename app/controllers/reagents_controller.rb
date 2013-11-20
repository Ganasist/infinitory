class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :set_lab, except: [:show, :edit, :update, :destroy, :index]
  before_action :authenticate_user!

  def index
    if params[:tag]
      @reagents = Reagent.tagged_with(params[:tag])
    else
      @lab = Lab.friendly.find(params[:lab_id])
      @reagents = Reagent.where(lab_id: @lab).order("updated_at DESC") 
    end
  end

  def show
    @lab = @reagent.lab
  end

  def new
    @reagent = Reagent.new
  end

  def edit
    @reagent = Reagent.find(params[:id])
  end

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

  def destroy
    @lab = @reagent.lab
    @reagent.destroy
    respond_to do |format|
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
    end
  end

  private
    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_lab
      @lab = Lab.friendly.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, :name, :category, :location, :price, :url, :serial,
                                      :properties, :description, :expiration, :tag_list, :user_ids => [])
    end
end
