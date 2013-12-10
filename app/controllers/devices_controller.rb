class DevicesController < ApplicationController
	before_action :set_device, only: [:show, :edit, :update, :destroy, :duplicate]
  before_action :set_lab, only: [:new, :create]
  before_action :authenticate_user!
  before_action :check_user!, only: :show

  def index
    if params[:tag].present?
      @devices = Device.tagged_with(params[:tag]).modified_recently.page(params[:page]).per_page(25)
    elsif params[:search].present?
      if params[:user_id].present?   
        @user = User.friendly.find(params[:user_id])
        @devices = @user.devices.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      elsif params[:lab_id].present?
        @lab = Lab.friendly.find(params[:lab_id]) 
        @devices = @lab.devices.text_search(params[:search]).modified_recently.page(params[:page]).per_page(25)
      end
    elsif params[:user_id].present?
      @user = User.friendly.find(params[:user_id])
      @devices = @user.devices.modified_recently.page(params[:page]).per_page(25)
    elsif params[:lab_id].present?
      @lab = Lab.friendly.find(params[:lab_id]) 
      @devices = @lab.devices.modified_recently.page(params[:page]).per_page(25)
    end
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

  def duplicate
    @duplicate = @device.amoeba_dup
    respond_to do |format|
      if @duplicate.save
        @duplicate.create_activity :create, owner: current_user
        format.html { redirect_to @duplicate, notice: 'device was successfully cloned.' }
        format.json { render action: 'show', status: :created, location: @duplicate }
      else
        format.html { render action: 'edit' }
        format.json { render json: @duplicate.errors, status: :unprocessable_entity }
      end
    end
  end

  def create
    @device = @lab.devices.new(device_params)
    respond_to do |format|
      if @device.save
        @device.create_activity :create, owner: current_user
        format.html { redirect_to @device, notice: 'device was successfully created.' }
        format.json { render action: 'show', status: :created, location: @device }
      else
        format.html { render action: 'new' }
        format.json { render json: @device.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @device.update(device_params)
        @device.create_activity :update, owner: current_user
        flash[:notice] = "#{ @device.name } has been updated."
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
    @device.destroy
    respond_to do |format|
      flash[:notice] = "#{ @device.name } has been removed."
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
      @lab = Lab.friendly.find(params[:lab_id])   
    end

    def device_params
      params.require(:device).permit(:lab_id, { :user_ids => [] }, :name, :category, :location, :price,
      															 :url, :serial, :description, :tag_list, :lock_version, :lot_number,
      															 :uid, :icon, :icon_cache, :remote_icon_url, :remove_icon)
    end



end
