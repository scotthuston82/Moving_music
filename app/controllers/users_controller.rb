class UsersController < ApplicationController

  before_action :ensure_user_profile_owner, only: [:edit, :update, :destroy]

  def index
    @users = User.where('kind = ?',  'musician')
  end

  def show
    @user = User.find(params[:id])
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

  def edit
    @user = current_user
  end

  def update
    @user = User.find(params[:id])
    @user.update!(user_params)

    if @user.save
      redirect_to user_url
    end
  end

  def destroy

  end

  def ensure_user_profile_owner
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      flash[:alert] = ["This is not your profile"]
      redirect_to users_url
    end
  end


  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :bio, :profile_picture)
  end
end
