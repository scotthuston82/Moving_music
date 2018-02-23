class BookingsController < ApplicationController
  skip_before_action :verify_authenticity_token

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
      render "new"
    end
  end

  def update
    Booking.find(params[:id]).update(confirmed: true)
    render json: {status: 'okay'}
  end

  def destroy
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :party_size, :age_range)
  end

end
