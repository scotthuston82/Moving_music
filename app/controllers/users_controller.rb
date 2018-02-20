class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:user][:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.kind = params[:kind]

    if @user.save
      redirect_to users_url
    end
  end

  def update

  end

  def destroy

  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation,)
  end
end
