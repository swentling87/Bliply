class UsersController < ApplicationController
  def index
  end

  def show
  end

  def edit_info
  end

  def update
    @user = current_user
    @user.assign_attributes(user_params)

    if @user.save
      flash[:notice] = "User profile information was updated."
      redirect_to user_path(current_user.id)
    else
      flash.now[:alert] = "There was an error updating your profile. Please try again."
      render :edit
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :age, :gender)
  end

end
