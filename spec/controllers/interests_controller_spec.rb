require 'rails_helper'
require 'devise'

RSpec.describe InterestsController, type: :controller do
  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @interest = FactoryGirl.create(:interest)
      sign_in :user, @user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, {user_id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET #new" do
      it "returns http success" do
        get :new, {user_id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "create interest" do
      it "creates a user interest" do
        expect{post :create, user_id: @user.id, interest: {user_id: @user.id, topic: "MyString"}}.to change(@user.interests,:count).by(1)
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

    describe "destroy interest" do
      it "destroys an interest" do
        delete :destroy, user_id: @user.id, id: @interest.id
        count = @user.interests.size
        expect(count).to eq 0
        expect(response).to redirect_to(user_path(@user.id))
      end
    end
  end
end
