class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy, :clone]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user_show!, only: :show
  before_action :check_user_index!, only: :index

  def index    
    if params[:search].present?      
      if params[:user_id].present?   
        @user = User.find(params[:user_id])
        @reagents = @user.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per(12)
      elsif params[:lab_id].present?
        @lab = Lab.find(params[:lab_id]) 
        @reagents = @lab.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per(12)
      end
    elsif params[:user_id].present?
      @user = User.find(params[:user_id])
      @reagents = @user.reagents.order(reagent_sort_column + ' ' + reagent_sort_direction).modified_recently.page(params[:page]).per(12)
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      @reagents = @lab.reagents.order(reagent_sort_column + ' ' + reagent_sort_direction).modified_recently.page(params[:page]).per(12)
    end
  end

  def show
    @activities = PublicActivity::Activity.includes(:trackable, :owner).where(trackable_id: params[:id]).where(trackable_type: "Reagent").group("activities.id").page(params[:page]).per(7).reverse_order
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
        ItemBackgroundWorker.perform_async("reagent", @reagent.id, 'created', current_user.id)
        format.html { redirect_to @reagent }
        format.json { render action: 'show', status: :created, location: @reagent }
      else
        format.html { render action: 'new' }
        format.json { render json: @reagent.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    @clone = @reagent.amoeba_dup
    respond_to do |format|
      if @clone.save
        @clone.create_activity :clone, owner: current_user
        ItemBackgroundWorker.perform_async("reagent", @reagent.id, 'cloned', current_user.id)
        format.html { redirect_to @clone, notice: "#{ fullname(@clone) } was successfully cloned." }
        format.json { render action: 'show', status: :created, location: @clone }
      else
        format.html { render action: 'edit', notice: "There was a problem cloning" }
        format.json { render json: @clone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @reagent.update(reagent_params)
        @reagent.create_activity :update, owner: current_user
        if @reagent.remaining < 21
          ReagentDepletionWorker.perform_async(@reagent.id)
        end
        format.html { redirect_to @reagent }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @reagent.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    send_destroy_comment(@reagent, 'removed')
    @lab = @reagent.lab
    @reagent.create_activity :delete, owner: current_user
    @reagent.destroy
    respond_to do |format|
      flash[:notice] = "#{ fullname(@reagent) } has been removed."
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def reagent_sort_column
      Reagent.column_names.include?(params[:sort]) ? params[:sort] : 'updated_at'
    end
    helper_method :reagent_sort_column
    
    def reagent_sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : 'desc'
    end
    helper_method :reagent_sort_direction

    def check_user_show!
      unless current_user.lab == @reagent.lab
        redirect_to current_user
        flash[:alert] = "You cannot access devices from that lab"
      end
    end

    def check_user_index!
      if params[:user_id] && (current_user != User.find(params[:user_id]))
        redirect_to current_user
        flash[:alert] = "You cannot access that member's device list"
      elsif params[:lab_id] && (current_user.lab != Lab.find(params[:lab_id]))
        redirect_to current_user
        flash[:alert] = "You cannot access devices from that lab"
      end
    end

    def set_reagent
      @reagent = Reagent.find(params[:id])
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, { :user_ids => [] }, :name, { :category_list => [] }, :location,
                                      :product_url, :purchasing_url, :serial, :price, :properties,
                                      :description, :expiration, :remaining, :tag_list,
                                      :quantity, :lot_number, :uid, :shared, :currency, :description, 
                                      :pdf, :delete_pdf, :pdf_remote_url,
                                      :icon, :delete_icon, :icon_remote_url)
    end
end
