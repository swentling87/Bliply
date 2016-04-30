require 'rails_helper'
require 'devise'

RSpec.describe PostsController, type: :controller do
  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @location = FactoryGirl.create(:location)
      @interest = FactoryGirl.create(:interest, id: 2)
      @u_post = FactoryGirl.create(:post, id: 4, user_id: @user.id, postable_id: @user.id, postable_type: "User")
      @l_post = FactoryGirl.create(:post, id: 5, user_id: @user.id, postable_id: @location.id, postable_type: "Location")
      @i_post = FactoryGirl.create(:post, id: 6, user_id: @user.id, postable_id: @interest.id, postable_type: "Interest")
      sign_in :user, @user
    end

    describe "GET new" do
      it "returns http success" do
        get :new, {id: @user.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view" do
        get :new, {id: @user.id}
        expect(response).to render_template :new
      end

      it "returns http success for a location" do
        get :new, {location_id: @location.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view for a location" do
        get :new, {location_id: @location.id}
        expect(response).to render_template :new
      end

      it "returns http success for an interest" do
        get :new, {interest_id: @interest.id}
        expect(response).to have_http_status(:success)
      end
      it "renders the #new view for an interest" do
        get :new, {interest_id: @interest.id}
        expect(response).to render_template :new
      end

    end

    describe "POST create" do
      it "increases the number of posts by 1 for a user post" do
        expect{ post :create, id: @user.id, post: {body: "My Stringy String User"} }.to change(Post,:count).by(1)
        expect(response).to redirect_to(users_path(@user))
      end
      it "increases the number of posts by 1 for a location post" do
        expect{ post :create, location_id: @location.id, post: {body: "My Stringy String Location"} }.to change(Post,:count).by(1)
        expect(response).to redirect_to(location_path(@location))
      end
      it "increases the number of posts by 1 for an interest post" do
        expect{ post :create, interest_id: @interest.id, post: {body: "My Stringy String Interest"} }.to change(Post,:count).by(1)
        expect(response).to redirect_to(interest_path(@interest))
      end

    end

    describe "DELETE destroy" do
      before do
        request.env["HTTP_REFERER"] = users_path(@user)
      end
      it "deletes the user post" do
        delete :destroy, id: @u_post.id, user_id: @user.id
        count = Post.where({id: @u_post.id}).size
        expect(count).to eq 0
        expect(response).to redirect_to(users_path(@user))
      end
      it "deletes the location post" do
        delete :destroy, id: @l_post.id, location_id: @location.id
        count = Post.where({id: @l_post.id}).size
        expect(count).to eq 0
        expect(response).to redirect_to(users_path(@user))
      end
      it "deletes the interest post" do
        delete :destroy, id: @i_post.id, interest_id: @interest.id
        count = Post.where({id: @i_post.id}).size
        expect(count).to eq 0
        expect(response).to redirect_to(users_path(@user))
      end
    end
  end
end
