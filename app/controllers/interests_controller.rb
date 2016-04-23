class InterestsController < ApplicationController

    def index
      @user = User.find(params[:user_id])
    end

    def new
      @interest = Interest.new
    end

    def create
      @interest = current_user.interests.create(interest_params)

      if @interest.save
        flash[:notice] = "You successfully added a new interest!"
        redirect_to user_path(current_user.id)
      else
        flash.now[:alert] = "There was an error saving that interest. Please try again."
        redirect_to user_path(current_user.id)
      end
    end

    def destroy
      @user = User.find(params[:user_id])
      @interest = Interest.find(params[:id])

      if @interest.destroy
        flash[:notice] = "You successfully removed that interest."
        redirect_to user_path(current_user.id)
      else
        flash.now[:alert] = "There was an error deleting that interest. Please try again."
        redirect_to user_path(current_user.id)
      end
    end

    def stealth
      @user = User.find(params[:user_id])
      @user_interest = @user.interestables.find(params[:id])
      @user_interest.toggle! :stealth
      if @user_interest.stealth == true
        @user_interest.save
        flash[:notice] = "You have successfully put that interest in stealth mode and it is now hidden."
        redirect_to user_interests_path(@user.id)
      else
        @user_interest.save
        flash[:notice] = "You have removed that interest from stealth mode, it is now visible."
        redirect_to user_interests_path(@user.id)
      end
    end


    private

    def interest_params
      params.require(:interest).permit(:topic)
    end

end
