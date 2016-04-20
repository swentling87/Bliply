class FriendshipsController < ApplicationController
  before_action :setup_friendship, except: [:index, :create, :accept]

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
    @friendship = Friendship.find(params[:id])
    @friend = User.find(params[:friend_id])
    Friendship.confirm(current_user, @friend)
    flash[:notice] = "Friendship with #{@friend.name} confirmed!"
    redirect_to user_friendships_path(current_user)
  end

  def decline
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Friendship with #{@friend.name} declined"
    redirect_to user_friendships_path(@user)
  end

  def cancel
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Friendship request canceled."
    redirect_to user_friendships_path(@user)
  end

  def destroy
    Friendship.unfriend(@user, @friend)
    flash[:notice] = "Removed friendship."
    redirect_to user_friendships_path(current_user)
  end

  private

  def setup_friendship
    @friendship = Friendship.find(params[:id])
    @friend = User.find(params[:friend_id])
    @user = User.find(params[:user_id])
  end

end
