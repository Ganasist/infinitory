class DevicesController < ApplicationController
	before_action :set_device, only: [:show, :edit, :update, :destroy, :clone]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user_show!, only: :show
  before_action :check_user_index!, only: :index

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      @devices = @user.device_ownerships.order(device_sort_column + ' ' + device_sort_direction).modified_recently.page(params[:page]).per(12)
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      @devices = @lab.devices.order(device_sort_column + ' ' + device_sort_direction).modified_recently.page(params[:page]).per(12)
    end    
  end

  def show
    @lab = current_user.lab
    @activities = PublicActivity::Activity.includes(:trackable, :owner).where(trackable_id: params[:id]).group("activities.id").page(params[:page]).per(7).reverse_order
  
    data_table = GoogleVisualr::DataTable.new
    data_table.new_column("number", "% Saturated" )

    data_table.add_rows(60)

    for i in 0..59 do
      data_table.set_cell(i,0,rand(100))
      i += 1
    end

    opts   = { width: 320, height: 60, showAxisLines: false,  showValueLabels: true, labelPosition: 'none' }
    @chart = GoogleVisualr::Image::SparkLine.new(data_table, opts)

  end

  def new
    @lab = current_user.lab
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
        send_comment(@device, "created")
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
        send_comment(@device, "cloned")
        format.html { redirect_to @clone, notice: "#{ fullname(@clone) } was successfully cloned." }
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
        flash[:notice] = "#{ fullname(@device) } has been updated."
        format.html { redirect_to @device, notice: "#{ fullname(@device) } has been updated." }
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
    send_comment(@device, 'removed')
    @device.destroy
    respond_to do |format|
      flash[:notice] = "#{ fullname(@device) } has been removed."
      format.html { redirect_to lab_devices_url(@lab) }
      format.json { head :no_content }
      format.js
    end
  end

  private
    def device_sort_column
      Device.column_names.include?(params[:sort]) ? params[:sort] : 'updated_at'
    end
    helper_method :device_sort_column
    
    def device_sort_direction
      %w[asc desc].include?(params[:direction]) ?  params[:direction] : 'desc'
    end
    helper_method :device_sort_direction

    def check_user_show!
      unless current_user.lab == @device.lab
        redirect_to current_user
        flash[:alert] = "You can't access devices from that lab"
      end
    end

    def check_user_index!
      if params[:user_id] && (current_user != User.find(params[:user_id]))
        redirect_to current_user
        flash[:alert] = "You can't access that member's device list"
      elsif params[:lab_id] && (current_user.lab != Lab.find(params[:lab_id]))
        redirect_to current_user
        flash[:alert] = "You can't access that lab's device list"
      end
    end

    def set_device
      @device = Device.find(params[:id])
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

    def device_params
      params.require(:device).permit(:lab_id, { :user_ownership_ids => [] }, :name, { :category_list => [] }, :location, :price,
      															 :product_url, :purchasing_url, :serial, :description, :bookable,
                                     :lock_version, :status, :uid, :shared, :currency,
                                     :pdf, :delete_pdf, :pdf_remote_url,
                                     :icon, :delete_icon, :icon_remote_url)
    end
end
