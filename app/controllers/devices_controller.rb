class DevicesController < ApplicationController
	before_action :set_device, only: [:show, :edit, :update, :destroy, :clone]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show

  def index
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column('string', 'Category')
    data_table.new_column('number', 'Relative amount')
    data_table.add_rows(Device::CATEGORIES.length)
    
    if params[:tag].present?
      @devices = Device.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(25)
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @devices = @user.devices.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      elsif params[:lab_id].present?
        @lab = Lab.find(params[:lab_id]) 
        @devices = @lab.devices.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      end
    elsif params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @devices = @user.devices.modified_recently.page(params[:page]).per_page(25)

      Device::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @user.devices_category_count("#{val}"))
      end
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      @devices = @lab.devices.modified_recently.page(params[:page]).per_page(25)
      
      Device::CATEGORIES.each_with_index do |val, index| 
        data_table.set_cell(index, 0, "#{val}".humanize)
        data_table.set_cell(index, 1, @lab.devices_category_count("#{val}"))
      end
    end
    
    @chart = GoogleVisualr::Interactive::PieChart.new(data_table, pie_options)
  end

  def show
    @lab = @device.lab
    @activities = PublicActivity::Activity.includes(:owner, :trackable).where(trackable_id: params[:id]).order('created_at desc')
  end

  def new
    @device = Device.new
  end

  def edit
    @device = Device.find(params[:id])
  end

  def create
    @device = @lab.devices.new(device_params)
    respond_to do |format|
      if @device.save
        @device.create_activity :create, owner: current_user
        format.html { redirect_to @device, notice: "#{fullname(@device)} was successfully created." }
        format.json { render action: 'show', status: :created, location: @device }
      else
        format.html { render action: 'new' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    @clone = @device.amoeba_dup
    respond_to do |format|
      if @clone.save
        @clone.create_activity :clone, owner: current_user
        @clone.users.each do |u|
          u.comments.create(comment: "#{fullname(@clone)} was cloned by #{current_user.fullname}")
        end
        format.html { redirect_to @clone, notice: "#{fullname(@clone)} was successfully cloned." }
        format.json { render action: 'show', status: :created, location: @clone }
      else
        format.html { render action: 'edit' }
        format.json { render json: @clone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        @device.create_activity :update, owner: current_user

        # IMPLEMENT DEVICE STATUS ONLINE / OFFLINE BOOLEAN ATTRIBUTE
        # if @device.status_changed? && @device.status == false
        #   @device.users.each do |u|
        #     u.comments.create(comment: "#{@device.name} was taken offline by #{current_user.fullname}.")
        #   end
        # elsif @device.status_changed? && @device.status == true
        #   @device.users.each do |u|
        #     u.comments.create(comment: "#{@device.name} was taken online by #{current_user.fullname}.")
        #   end
        # end

        flash[:notice] = "#{ fullname(@device) } has been updated."
        format.html { redirect_to @device }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lab = @device.lab
    @device.create_activity :delete, owner: current_user
    @device.users.each do |u|
        u.comments.create(comment: "#{ fullname(@device) } was deleted by #{current_user.fullname}")
      end
    @lab.comments.create(comment: "#{ fullname(@device) } was deleted by #{current_user.fullname}")
    @device.destroy
    respond_to do |format|
      flash[:notice] = "#{ fullname(@device) } has been removed."
      format.html { redirect_to lab_devices_url(@lab) }
      format.json { head :no_content }
    end
  end

  private

    def check_user!
      if current_user.lab != Device.find(params[:id]).lab
        redirect_to current_user
        flash[:alert] = "You cannot access devices from that lab"
      end
    end

    def set_device
      @device = Device.find(params[:id])
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

    def device_params
      params.require(:device).permit(:lab_id, { :user_ids => [] }, :name, :category, :location, :price,
      															 :url, :serial, :description, :tag_list, :lock_version, :status,
      															 :uid, :icon, :icon_cache, :remote_icon_url, :remove_icon)
    end
end
