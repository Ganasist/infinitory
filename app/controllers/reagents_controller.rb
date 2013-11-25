class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show
  helper_method :expiring?

  def index
    if params[:tag].present?
      @reagents = Reagent.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(15)
    elsif !params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @reagents = @user.reagents.modified_recently.page(params[:page]).per_page(15)
      elsif params[:lab_id].present?
        @lab = Lab.friendly.find(params[:lab_id]) 
        @reagents = @lab.reagents.modified_recently.page(params[:page]).per_page(15)
      end
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @reagents = @user.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(15)
      elsif params[:lab_id].present?
        @lab = Lab.friendly.find(params[:lab_id]) 
        @reagents = @lab.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(15)
      end
    # else
     # @reagents = current_user.reagents.modified_recently.page(params[:page]).per_page(15)
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
        flash[:notice] = "#{ @reagent.name } has been updated. #{ undo_link }"
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
    @reagent.destroy
    respond_to do |format|
      flash[:notice] = "#{ @reagent.name } has been removed. #{ undo_link }"
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
    end
  end

  private

    def expiring?
      (@reagent.expiration - Date.today).to_i < 30
    end

    def check_user!
      if current_user.lab != Reagent.find(params[:id]).lab
        redirect_to current_user
        flash[:alert] = "You cannot access reagents from other labs"
      end
    end

    def undo_link
      view_context.link_to("UNDO", revert_version_path(@reagent.versions.last), 
                            method: :post, class: "btn-large")
    end

    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_lab
      @lab = Lab.friendly.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, { :user_ids => [] }, :name, :category, :location, :price, :url, :serial,
                                      :properties, :description, :expiration, :remaining, :tag_list, :lock_version)
    end
end
