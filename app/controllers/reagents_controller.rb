class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show

  def index
    if params[:tag].present?
      @reagents = Reagent.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(25)
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @reagents = @user.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      elsif params[:lab_id].present?
        @lab = Lab.friendly.find(params[:lab_id]) 
        @reagents = @lab.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      end
    elsif params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @reagents = @user.reagents.modified_recently.page(params[:page]).per_page(25)
    elsif params[:lab_id].present?
      @lab = Lab.friendly.find(params[:lab_id]) 
      @reagents = @lab.reagents.modified_recently.page(params[:page]).per_page(25)
    end
  end

  def show
    @lab = @reagent.lab
    @activities = PublicActivity::Activity.includes(:owner).where(trackable_id: params[:id])
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
        @reagent.create_activity :create, owner: current_user
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
        @reagent.create_activity :update, owner: current_user
        flash[:notice] = "#{ @reagent.name } has been updated."
        format.html { redirect_to @reagent }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reagent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lab = @reagent.lab
    @reagent.create_activity :delete, owner: current_user
    @reagent.destroy
    respond_to do |format|
      flash[:notice] = "#{ @reagent.name } has been removed."
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
    end
  end

  private

    def check_user!
      if current_user.lab != Reagent.find(params[:id]).lab
        redirect_to current_user
        flash[:alert] = "You cannot access reagents from that lab"
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
                                      :properties, :description, :expiration, :remaining, :tag_list, :lock_version,
                                      :lot_number, :uid, :icon, :icon_cache, :remote_icon_url, :remove_icon)
    end
end
