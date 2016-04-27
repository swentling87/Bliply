class LocationsController < ApplicationController

  def index
  end

  def show
    @location = Location.find(params[:id])
  end

  def new
    @location = Location.new
  end

  def create
    @user = current_user
    @location = Location.find_or_create_by(location_params)
    @user.locations << @location

    if @location.save
      flash[:notice] = "You successfully added a new location!"
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "There was an error saving that location. Please try again."
      redirect_to user_path(current_user.id)
    end
  end

  def destroy
    @user = User.find(params[:user_id])
    @location = Location.find(params[:id])

    if @location.destroy
      flash[:notice] = "You successfully removed that location."
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "There was an error deleting that location. Please try again."
      redirect_to user_path(current_user.id)
    end
  end

  private

  def location_params
    params.require(:location).permit(:zip_code)
  end

end
