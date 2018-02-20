class SessionsController < ApplicationController

  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.autenticate(params[:password])
      session[:user_id] = user.id
      if user.kind = 'client'
        redirect_to users_path
      else
        redirect_to user_path(user.id)
      end
    else
      flash[:notice] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to users_path, notice: "Logged out"
  end

end
