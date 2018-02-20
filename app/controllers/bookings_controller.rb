class BookingsController < ApplicationController

  def new
    @booking = Booking.new
    @musician = User.find(params[:user_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @musician = User.find(params[:user_id])
    @booking.musician = @musician
    @booking.client = current_user
    if @booking.save
      redirect_to user_url(@musician)
    else
      flash.now[:alert] = ["Something went wrong, please try again!"]
      render
    end
  end

  def destroy
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :party_size, :age_range)
  end

end
