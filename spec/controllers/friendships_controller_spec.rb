require 'rails_helper'
require 'devise'

RSpec.describe FriendshipsController, type: :controller do

  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @fuser = FactoryGirl.create(:user, email: "fuser@bliply.com", id: 2)
      @requested_friend = FactoryGirl.create(:friendship, status: "requested", user_id: @user.id, friend_id: @fuser.id, id: 10)
      @pending_friend = FactoryGirl.create(:friendship, status: "pending", user_id: @fuser.id, friend_id: @user.id, id: 11)
      sign_in :user, @user
    end
    describe "GET #index" do
      it "returns http success" do
        get :index, {user_id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "request friend" do
      it "sends a friend request" do
        expect{post :create, user_id: @user.id, friend_id: @fuser.id, friendship: {user_id: @user.id, friend_id: @fuser.id}}.to change(@user.friendships,:count).by(1)
      end
    end

    describe "accept friend" do
      it "accepts a friend request" do
      end
    end

    describe "decline friend" do
      it "declines a friend request" do
        delete :decline, id: @requested_friend.id, user_id: @requested_friend.user_id, friend_id: @requested_friend.friend_id
        count = Friendship.all.size
        expect(count).to eq 0
        expect(response).to redirect_to(user_friendships_path(@user))
      end
    end

    describe "cancel friend" do
      it "cancels a friend request" do
        delete :cancel, id: @requested_friend.id, user_id: @requested_friend.user_id, friend_id: @requested_friend.friend_id
        count = Friendship.all.size
        expect(count).to eq 0
        expect(response).to redirect_to(user_friendships_path(@user))
      end
    end

    describe "un-friend" do
      it "destroys a friendship" do
        @confirmed_friend = FactoryGirl.create(:friendship, status: "confirmed", user_id: @fuser.id, friend_id: @user.id, id: 12)
        delete :destroy, id: @confirmed_friend.id, user_id: @confirmed_friend.user_id, friend_id: @confirmed_friend.friend_id
        count = @user.friends.size
        expect(count).to eq 0
        expect(response).to redirect_to(user_friendships_path(@user))
      end
    end

    describe "confirm friend" do
      it "confirms a friendship" do
        get :accept, id: @requested_friend.id, user_id: @requested_friend.user_id, friend_id: @requested_friend.friend_id
        count = @user.friends.size
        expect(count).to eq 1
        expect(response).to redirect_to(user_friendships_path(@user))
      end
    end

  end
end
