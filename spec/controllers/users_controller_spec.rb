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
    describe "Update" do
      it "updates a user" do
        new_name = "hello"
        new_age = 25
        new_gender = 1
        put :update, id: @user.id, user: {name: new_name, age: new_age, gender: new_gender}
        updated_user = assigns(:user)

        expect(updated_user.id).to eq @user.id
        expect(updated_user.name).to eq new_name
        expect(updated_user.age).to eq new_age
        expect(updated_user.gender).to eq new_gender
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

    describe "stealth" do
      it "makes a user go into stealth mode" do
        put :stealth, id: @user.id, user: {stealth: true }
        updated_user = assigns(:user)
        expect(updated_user.stealth).to eq true
        expect(response).to redirect_to(user_path(@user.id))
      end
    end
  end
end
