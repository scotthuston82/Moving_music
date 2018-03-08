class ReviewsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @booking = Booking.find(params[:booking_id])
    @review = Review.new
  end

  def create
    @user = User.find(params[:user_id])
    @booking = Booking.find(params[:booking_id])
    if @booking.review == nil
      @review = Review.new
      @review.client = @booking.client
      @review.musician = @booking.musician
      @review.booking = @booking
        if current_user.kind == "client"
          @review.musicians_review = params[:review][:musicians_review]
          @review.musician_reviewed = true
        elsif current_user.kind == "musician"
          @review.clients_review = params[:review][:clients_review]
          @review.client_reviewed = true
        end
    else
      @review = @booking.review
      if current_user.kind == "client"
        @review.musicians_review = params[:review][:musicians_review]
        @review.musician_reviewed = true
      elsif current_user.kind == "musician"
        @review.clients_review = params[:review][:clients_review]
        @review.client_reviewed = true
      end
    end

    if @review.save
      flash.now![:notice] = "Successfully submitted Review!"
      redirect_to user_path(@user)
    else
      render 'users/show'
    end
  end



end
