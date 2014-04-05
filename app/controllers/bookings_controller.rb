class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  def index
    @device = Device.find(params[:device_id])
    @bookings = @device.bookings
    # @bookings = Booking.all
  end

  # GET /bookings/1
  def show
    @device = @booking.device
  end

  # GET /bookings/new
  def new
    @device = Device.find(params[:device_id])
    @booking = Booking.new
  end

  # GET /bookings/1/edit
  def edit
    @user = current_user
  end

  # POST /bookings
  def create
    @device = Device.find(params[:device_id])
    @booking = @device.bookings.new(booking_params)
    if @booking.save
      redirect_to @booking, notice: 'Booking was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /bookings/1
  def update
    if @booking.update(booking_params)
      redirect_to @booking, notice: 'Booking was successfully updated.'
    else
      render action: 'edit'
    end
  end

  # DELETE /bookings/1
  def destroy
    @device = @booking.device
    @booking.destroy
    redirect_to device_bookings_url(@device), notice: 'Booking was successfully destroyed.'
  end

  private
    def set_booking
      @booking = Booking.find(params[:id])
    end

    def booking_params
      params.require(:booking).permit(:title, :description, :start_time, :end_time, :device_id, :user_id)
    end
end
