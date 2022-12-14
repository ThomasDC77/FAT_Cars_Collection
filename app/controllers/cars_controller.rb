class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_car, only: %i[show edit update destroy]

  def index
    @cars = params[:origin].present? ? Car.where(origin: params[:origin]) : Car.all
    @q = @cars.ransack(params[:q])
    @cars = @q.result(distinct: true)

    @markers = @cars.geocoded.map do |car|
      {
        id: car.id.to_s,
        lat: car.latitude,
        lng: car.longitude,
        info_window: render_to_string(partial: "info_window", locals: {car: car})
      }
    end
  end

  def show
    @booking = Booking.new
    @dates = @car.bookings.map(&:date)
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to cars_path(@car)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    @car.update(car_params)
    redirect_to profile_owner_path(@car)
  end

  def destroy
    if @car.bookings.present?
      redirect_to car_path, status: :unprocessable_entity
    else
      @car.destroy
      redirect_to profile_owner_path(@car)
    end
  end

  private

  def car_params
    params.require(:car).permit(:brand, :origin, :model, :year, :price_per_day, :color, :number_street, :name_street, :post_code, :description, :city, :photo)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
