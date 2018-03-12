class EquipmentController < ApplicationController
  before_action :ensure_owner

  def new
    @equipment = Equipment.new
    @musician = User.find(params[:user_id])
  end

  def create
    @equipment = Equipment.new(equipment_params)
    @equipment.musician = current_user
    if @equipment.save
      flash[:notice] = "Successfully added equipment to your profile"

    else
      flash.now[:alert] = @equipment.errors.full_messages
      render "new"
    end
  end

  def edit

  end

  def update

  end

  def destroy

  end

  def equipment_params
    params.require(:equipment).permit(:category, :details, :price)
  end

  def ensure_owner
    @musician = User.find(params[:user_id])
    if session[:user_id] != @musician.id
      flash[:alert] = ["You cannot add equipment to an account you don't own"]
      redirect_to users_url
    end
  end
end
