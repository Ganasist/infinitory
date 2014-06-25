class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]
  before_action :check_device_bookable

  def index
    if params[:device_id]
      @device = Device.find(params[:device_id])
      @bookings = @device.bookings.page(params[:page]).end_time_desc
      @calendar_data = @device.bookings.end_time_desc.limit(100)
    elsif params[:user_id]
      @user = User.find(params[:user_id])
      @bookings = @user.bookings.page(params[:page]).end_time_desc
      @calendar_data = @user.bookings.end_time_desc.limit(100)
    end
  end

  def show
    @device = @booking.device
  end

  def new
    @device = Device.find(params[:device_id])
    @booking = Booking.new
    @bookings = @device.bookings
  end

  def edit
    @user = current_user
    @booking = Booking.find(params[:id])
    @bookings = @booking.device.bookings
  end

  def create
    @device = Device.find(params[:device_id])
    @booking = @device.bookings.new(booking_params)
    if @booking.save
      redirect_to device_bookings_path(@booking.device)
    else
      flash[:error] = 'There was a problem booking this device'
      render action: 'new'
    end
  end

  def update
    if @booking.update(booking_params)
      redirect_to device_bookings_path(@booking.device)
    else
      flash[:error] = 'There was a problem editing this booking'
      render action: 'edit'
    end
  end

  def destroy
    @device = @booking.device
    @booking.destroy
    redirect_to device_bookings_url(@device), notice: 'Booking removed.'
  end

  private
    def check_device_bookable
      if params[:device_id]
        unless Device.find(params[:device_id]).bookable?
          redirect_to current_user
          flash[:alert] = "That device is not bookable"
        end
      end
    end

    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:title, :description, :start_time, :end_time, :device_id, :user_id)
    end
end
