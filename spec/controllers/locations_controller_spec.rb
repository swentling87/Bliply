require 'rails_helper'
require 'devise'

RSpec.describe LocationsController, type: :controller do
  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @location = FactoryGirl.create(:location)
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

    describe "create location" do
      it "creates a user location" do
        expect{post :create, user_id: @user.id, location: {user_id: @user.id, zip_code: 12345}}.to change(@user.locations,:count).by(1)
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

    describe "destroy location" do
      it "destroys an location" do
        delete :destroy, user_id: @user.id, id: @location.id
        count = @user.locations.size
        expect(count).to eq 0
        expect(response).to redirect_to(user_path(@user.id))
      end
    end
  end
end
