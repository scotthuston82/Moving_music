class ReviewsController < ApplicationController

  def create

    @user = User.find(params[:user_id])
    @review = @user.musician_reviews.new
    @review.comment = params[:review][:comment]
    @review.client_id = current_user.id

    if @review.save
      flash[:notice] = "Successfully submitted Review!"
      redirect_to user_path(@user)
    else
      render 'users/show'
    end
  end



end
