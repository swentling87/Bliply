class FriendshipsController < ApplicationController

  def index
  end

  def create
    @friend = User.find(params[:friend_id])
    Friendship.request(current_user, @friend)

    flash[:notice] = "Friend request sent."
    redirect_to user_path(current_user)
  end

  def accept
    Friendship.confirm(current_user, @friend)
    flash[:notice] = "Friendship with #{@friend.name} confirmed!"
    redirect_to user_path(current_user)
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.unfriend(@user, @friend)
      flash[:notice] = "Friendship with #{@friend.name} declined"
    else
      flash[:notice] = "No friendship request from #{@friend.name}."
    end
    redirect_to user_path(current_user)
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.unfriend(@user, @friend)
      flash[:notice] = "Friendship request canceled."
    else
      flash[:notice] = "No request for friendship with #{@friend.name}"
    end
    redirect_to user_path(current_user)
  end

  def destroy
    @friendship = current_user.friendships.find(params[:id])
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to user_path(current_user)
  end

  private

  def setup_friends
    @friend = User.find(params[:id])
  end

end
