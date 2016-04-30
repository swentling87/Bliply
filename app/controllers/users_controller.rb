class UsersController < ApplicationController
  def index
    @posts = Post.all.includes(:postable)
  end

  def show
    @user = User.find(params[:id])
  end

  def edit_info
  end

  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)

    if @user.save
      flash[:notice] = "User profile information was updated."
      redirect_to user_path(@user.id)
    else
      flash.now[:alert] = "There was an error updating your profile. Please try again."
      render :edit
    end
  end

  def stealth
    @user = current_user
    @user.toggle! :stealth
    if @user.stealth == true
      @user.save
      flash[:notice] = "You have gone to stealth mode. Your personal information is hidden."
      redirect_to user_path(@user.id)
    else
      @user.save
      flash[:notice] = "You have exited stealth mode. Your personal information is now visible."
      redirect_to user_path(@user.id)
    end
  end


  private

  def user_params
    params.require(:user).permit(:name, :age, :gender)
  end

end
