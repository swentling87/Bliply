require 'rails_helper'
require 'devise'

RSpec.describe UsersController, type: :controller do

  context "user" do
    before do
      @user = FactoryGirl.create(:user)
      sign_in :user, @user
    end
    describe "GET #show" do
      it "returns http success" do
        get :show, {id: @user.id}
        expect(response).to have_http_status(:success)
      end
    end
    describe "GET #index" do
      it "returns http success" do
        get :index
        expect(response).to have_http_status(:success)
      end
    end
  end
end
