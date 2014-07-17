class DevicesController < ApplicationController
	before_action :set_device, only: [:show, :edit, :update, :destroy, :clone]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  after_action :verify_authorized

  def index
    if params[:user_id].present?
      @user = User.find(params[:user_id])
      authorize @user, :item_indexes?
      @devices = @user.device_ownerships
                      .order(device_sort_column + ' ' + device_sort_direction)
                      .modified_recently
                      .page(params[:page]).per(12)
    elsif params[:lab_id].present?
      @lab = Lab.find(params[:lab_id]) 
      authorize @lab, :item_indexes?
      @devices = @lab.devices
                     .order(device_sort_column + ' ' + device_sort_direction)
                     .modified_recently
                     .page(params[:page])
                     .per(12)
    end    
  end

  def show
    authorize @device
    @lab = current_user.lab
    @activities = PublicActivity::Activity.includes(:trackable, :owner)
                                          .where('trackable_id=? AND trackable_type=?', params[:id], "Device")
                                          .group("activities.id")
                                          .page(params[:page])
                                          .per(7)
                                          .reverse_order
    @chart = GoogleSparkliner.new(@device, 320).draw_random
  end

  def new
    @device = Device.new
    authorize @lab, :own_item?
  end

  def edit
    authorize @device
  end

  def create
    @device = @lab.devices.new(device_params)
    authorize @lab, :own_item?
    respond_to do |format|
      if @device.save
        @device.create_activity :create, owner: current_user
        ItemBackgroundWorker.perform_async("device", @device.id, 'created', current_user.id)
        format.html { redirect_to @device }
        format.json { render action: 'show', status: :created, location: @device }
      else
        format.html { render action: 'new' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def clone
    authorize @device
    @clone = @device.amoeba_dup
    respond_to do |format|
      if @clone.save
        @clone.create_activity :clone, owner: current_user
        ItemBackgroundWorker.perform_async("device", @device.id, 'cloned', current_user.id)
        format.html { redirect_to @clone, notice: "#{ @clone.fullname } was successfully cloned." }
        format.json { render action: 'show', status: :created, location: @clone }
      else
        format.html { render action: 'show', error: "There was a problem cloning this device" }
        format.json { render json: @clone.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    authorize @device
    respond_to do |format|
      if @device.update(device_params)
        @device.create_activity :update, owner: current_user
        format.html { redirect_to @device }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    authorize @device
    send_destroy_comment(@device, 'removed')
    @lab = @device.lab
    @device.create_activity :delete, owner: current_user
    @device.destroy
    respond_to do |format|
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

    def set_device
      @device = Device.find(params[:id])
    end

    def set_lab
      @lab = Lab.find(params[:lab_id])   
    end

    def device_params
      params.require(:device).permit(:lab_id, { :user_ids => [] }, :name,
                                     { :category_list => [] }, :location, :price,
      															 :product_url, :purchasing_url, :serial, :description,
                                     :bookable, :status, :uid, :shared, 
                                     :currency, :pdf, :delete_pdf, :pdf_remote_url,
                                     :icon, :delete_icon, :icon_remote_url)
    end
end
