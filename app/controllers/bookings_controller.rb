class BookingsController < ApplicationController
  before_action :set_booking, only: %i[destroy edit update]
  def new
    @booking = Booking.new
  end

  def create
    @car = Car.find(params[:car_id])
    @booking = Booking.new(booking_params)
    @booking.car = @car
    @booking.user = current_user
    if @booking.save
      redirect_to profile_path
    else
      redirect_to cars_path(@car), status: :unprocessable_entity
    end
  end

  def destroy
    @booking.destroy
    redirect_to profile_path
  end

  def edit
  end

  def update
    @booking.update(booking_params)
    redirect_to profile_path
  end

  private

  def booking_params
    params.require(:booking).permit(:date)
  end

  def set_booking
    @booking = Booking.find(params[:id])
  end
end
