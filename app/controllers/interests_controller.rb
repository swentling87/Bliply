class InterestsController < ApplicationController

    def index
      @user = User.find(params[:user_id])
      @interestable = Interestable.find_by_user_id_and_interest_id(:user_id, :interest_id)
    end

    def show
      @interest = Interest.find(params[:id])
    end

    def new
      @interest = Interest.new
    end

    def create
      if interest_params.present?
        interest_params[:topic].downcase!
        @user = current_user
        @interest = Interest.find_or_create_by(interest_params)
        @user.interests << @interest

        if @interest.save
          flash[:notice] = "You successfully added a new interest!"
          redirect_to user_path(current_user.id)
        else
          flash.now[:alert] = "There was an error saving that interest. Please try again."
          redirect_to user_path(current_user.id)
        end
      end
    end

    def destroy
      @user = current_user
      @interest = Interest.find(params[:id])
      @interestable = Interestable.find_by_user_id_and_interest_id(@user.id, @interest.id)
      @posts = @interest.posts.where(user_id: @user.id)
      if @interestable.destroy
        @posts.destroy_all
        flash[:notice] = "You successfully removed that interest."
        redirect_to user_path(current_user.id)
      else
        flash.now[:alert] = "There was an error deleting that interest. Please try again."
        redirect_to user_path(current_user.id)
      end

      if @interest.users.count == 0
        @interest.destroy
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
