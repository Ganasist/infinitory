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
      @reagents = Reagent.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(25)
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @reagents = @user.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      elsif params[:lab_id].present?
        @lab = Lab.find(params[:lab_id]) 
        @reagents = @lab.reagents.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      end
    elsif params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @reagents = @user.reagents.modified_recently.page(params[:page]).per_page(25)      

      Reagent::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @user.relative_reagents_percentage("#{val}"))
      end
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      @reagents = @lab.reagents.modified_recently.page(params[:page]).per_page(25)
      Reagent::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @lab.relative_reagents_percentage("#{val}"))
      end   
    end

    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, pie_options)
  end

  def show
    @lab = @reagent.lab
    @activities = PublicActivity::Activity.includes(:owner, :trackable).where(trackable_id: params[:id]).order('created_at desc')
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
        format.html { redirect_to @reagent, notice: "#{@reagent.name} was successfully created." }
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
        @clone.users.each do |u|
          u.comments.create(comment: "A new copy of #{@clone.name} was cloned by #{current_user.fullname}")
        end 
        format.html { redirect_to @clone, notice: "#{@clone.name} was successfully cloned." }
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
          @reagent.users.each do |u|
            u.comments.create(comment: "#{@reagent.name} had only #{@reagent.remaining}% remaining")
          end
        end        
        flash[:notice] = "#{@reagent.name} has been updated."
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
    @reagent.users.each do |u|
        u.comments.create(comment: "#{@reagent.name} was deleted by #{current_user.fullname}")
      end
    @reagent.destroy
    respond_to do |format|
      flash[:notice] = "#{@reagent.name} has been removed."
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
      @lab = Lab.find(params[:lab_id])   
    end

    def reagent_params
      params.require(:reagent).permit(:lab_id, { :user_ids => [] }, :name, :category, :location, :price, :url, :serial,
                                      :properties, :description, :expiration, :remaining, :tag_list, :lock_version,
                                      :quantity, :lot_number, :uid, :icon, :icon_cache, :remote_icon_url, :remove_icon)
    end
end
