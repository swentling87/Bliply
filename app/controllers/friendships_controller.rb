class FriendshipsController < ApplicationController

  def index
  end

  def create
    @friend = User.find(params[:friend_id])
    @user = User.find(params[:user_id])
    Friendship.request(@user, @friend)
    flash[:notice] = "Friend request sent."
    redirect_to user_friendships_path(@user)
  end

  def accept
    @friend = User.find(params[:id])
    Friendship.confirm(current_user, @friend)
    flash[:notice] = "Friendship with #{@friend.name} confirmed!"
    redirect_to user_friendships_path(current_user)
  end

  def decline
    @friend = User.find(params[:id])
    @user = User.find(params[:user_id])
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Friendship with #{@friend.name} declined"
    redirect_to user_friendships_path(@user)
  end

  def cancel
    @friend = User.find(params[:id])
    @user = User.find(params[:user_id])
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Friendship request canceled."
    redirect_to user_friendships_path(@user)
  end

  def destroy
    @friend = User.find(params[:id])
    @user = User.find(params[:user_id])
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Removed friendship."
    redirect_to user_friendships_path(current_user)
  end

end
