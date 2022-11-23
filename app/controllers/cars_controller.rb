class CarsController < ApplicationController
  skip_before_action :authenticate_user!, only: %i[index show]
  before_action :set_car, only: %i[show edit update destroy]
  def index
    @cars = Car.all
    @q = Car.ransack(params[:q])
    @cars = @q.result(distinct: true)
  end

  def show
    @booking = Booking.new
  end

  def new
    @car = Car.new
  end

  def create
    @car = Car.new(car_params)
    @car.user = current_user
    if @car.save
      redirect_to cars_path
    else
      render :new
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
    params.require(:car).permit(:brand, :year, :price_per_day, :color, :number_street, :name_street, :post_code, :description, :city, :photo)
  end

  def set_car
    @car = Car.find(params[:id])
  end
end
