require 'rails_helper'
require 'devise'

RSpec.describe InterestsController, type: :controller do
  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @interest = FactoryGirl.create(:interest, id: 2)
      @interestable = FactoryGirl.create(:interestable, user_id: 1, interest_id: 2, id: 10)
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
        get :show, {id: @interest.id}
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
      it "destroys an interestestable and interest" do
        delete :destroy, user_id: @user.id, id: @interest.id, interestable: {id: @interestable.id, user_id: @user.id, interest_id: @interest.id}
        count = Interestable.where({id: @interestable.id}).size
        i_count = @user.interests.size
        expect(count).to eq 0
        expect(i_count).to eq 0
        expect(response).to redirect_to(user_path(@user.id))
      end
    end

    describe "stealth" do
      it "makes an interest go into stealth mode" do
        put :stealth, user_id: @user.id, id: @interestable.id, interestable: {stealth: true, id: @interestable.id, user_id: @user.id, interest_id: @interest.id }
        updated_interestable = assigns(:user_interest)
        expect(updated_interestable.stealth).to eq true
        expect(response).to redirect_to(user_interests_path(@user.id))
      end
    end

    describe "leave stealth" do
      before do
        @t_interestable = FactoryGirl.create(:interestable, user_id: 1, interest_id: 2, id: 11, stealth: true)
      end
      it "makes an interest leave stealth mode" do
        put :stealth, user_id: @user.id, id: @t_interestable.id, interestable: {stealth: false, id: @t_interestable.id, user_id: @user.id, interest_id: @interest.id }
        updated_interestable = assigns(:user_interest)
        expect(updated_interestable.stealth).to eq false
        expect(response).to redirect_to(user_interests_path(@user.id))
      end
    end
  end
end
