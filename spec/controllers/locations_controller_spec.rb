require 'rails_helper'
require 'devise'

RSpec.describe LocationsController, type: :controller do
  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @location = FactoryGirl.create(:location, id: 2)
      @locationable = FactoryGirl.create(:locationable, user_id: 1, location_id: 2, id: 10)
      sign_in :user, @user
    end

    describe "GET #index" do
      it "returns http success" do
        get :index, {user_id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end

    describe "get #show" do
      it "returns http success" do
        get :show, {id: @location.id}
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
      it "destroys a locationable and location" do
        delete :destroy, user_id: @user.id, id: @location.id, locationable: {id: @locationable.id, user_id: @user.id, location_id: @location.id}
        count = Locationable.where({id: @locationable.id}).size
        l_count = @user.locations.size
        expect(count).to eq 0
        expect(l_count).to eq 0
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

  end
end
