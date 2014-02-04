class ReagentsController < ApplicationController
  before_action :set_reagent, only: [:show, :edit, :update, :destroy, :clone]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show

  def index
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Category')
    data_table.new_column('number', 'Relative amount')
    data_table.add_rows(Reagent::CATEGORIES.length)
    
    if params[:tag].present?
      @reagents = Reagent.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(12)
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @reagents = @user.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(12)
      elsif params[:lab_id].present?
        @lab = Lab.find(params[:lab_id]) 
        @reagents = @lab.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(12)
      end
    elsif params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @reagents = @user.reagents.modified_recently.page(params[:page]).per_page(12)      
      Reagent::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @user.reagents_category_count("#{val}"))
      end
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      @reagents = @lab.reagents.modified_recently.page(params[:page]).per_page(12)
      Reagent::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @lab.reagents_category_count("#{val}"))
      end   
    end
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, pie_options)
    
  end

  def show
    @activities = PublicActivity::Activity.includes(:trackable, :owner).where(trackable_id: params[:id]).page(params[:page]).per_page(7).reverse_order
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
        send_comment(@reagent, "created")
        format.html { redirect_to @reagent, notice: "#{ fullname(@reagent) } was successfully created." }
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
        send_comment(@reagent, "cloned")
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
          @reagent.reagent_low
        end        
        flash[:notice] = "#{ fullname(@reagent) } has been updated."
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
    send_comment(@reagent, "removed")
    @reagent.destroy
    respond_to do |format|
      flash[:notice] = "#{ fullname(@reagent) } has been removed."
      format.html { redirect_to lab_reagents_url(@lab) }
      format.json { head :no_content }
    end
    # expire_fragment "current_user"
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
      @lab = Lab.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, { :user_ids => [] }, :name, :category, :location,
                                      :product_url, :purchasing_url, :serial, :price, :properties,
                                      :description, :expiration, :remaining, :tag_list, :lock_version,
                                      :quantity, :lot_number, :uid, :public, 
                                      :pdf, :delete_pdf, :pdf_remote_url,
                                      :icon, :delete_icon, :icon_remote_url)
    end
end
