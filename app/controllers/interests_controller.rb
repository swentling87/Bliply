class InterestsController < ApplicationController

    def index
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

    private

    def interest_params
      params.require(:interest).permit(:topic)
    end

end
