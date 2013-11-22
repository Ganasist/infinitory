class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show

  def index
    if params[:tag].present?
      @reagents = Reagent.order("updated_at DESC").tagged_with(params[:tag]).
                    page(params[:page]).per_page(15)
    elsif params[:search].present?
      @lab = Lab.friendly.find(params[:lab_id])
      @reagents = Reagent.where(lab_id: @lab).order("updated_at DESC").
                    text_search(params[:search]).page(params[:page]).per_page(15)
    else
      @lab = Lab.friendly.find(params[:lab_id]) 
      @reagents = Reagent.where(lab_id: @lab).order("updated_at DESC").
                    page(params[:page]).per_page(15)
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
    def check_user!
      if current_user.lab != Reagent.find(params[:id]).lab
        redirect_to current_user
        flash[:alert] = "You cannot access reagents from another lab"
      end
    end

    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_lab
      @lab = Lab.friendly.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, { :user_ids => [] }, :name, :category, :location, :price, :url, :serial,
                                      :properties, :description, :expiration, :remaining, :tag_list)
    end
end
