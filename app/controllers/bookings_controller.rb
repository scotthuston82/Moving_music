class BookingsController < ApplicationController
  require 'json'
  skip_before_action :verify_authenticity_token

  def new
    @booking = Booking.new
    @musician = User.find(params[:user_id])
  end

  def new_no_musician
    @booking = Booking.new
    @booking.client = current_user
    @genres = Genre.all
  end

  def search_musicians
    @booking = Booking.new(booking_params)
    @musicians = SearchMusicians.new(params).results
    render 'find_musicians', layout: false
  end

  def musicians_in_radius
    @musicians = User.where('kind = ?', 'musician')
    respond_to do |format|
      format.json {render :json => @musicians}
    end
  end

  def confirmation
    @booking = Booking.new(booking_params)
    @musician = User.find(params[:user_id])
  end

  def create
    @booking = Booking.new(booking_params)
    @musician = User.find(params[:user_id])
    @booking.musician = @musician
    @booking.client = current_user
    if @booking.save
      redirect_to user_url(current_user)
    else
      flash.now[:alert] = @booking.errors.full_messages
      render "new"
    end
  end

  def update
    Booking.find(params[:id]).update(confirmed: true)
    render json: {status: 'okay'}
  end

  def destroy
    Booking.find(params[:id]).delete
    render json: {status: 'okay'}
  end

  def map
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :address, :party_size, :age_range, :event_name, equipment_ids: [])
  end

end
