require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do

  context "true stealthy" do
    before do
      @user = FactoryGirl.create(:user, stealth: true)
    end
    describe "stealthy" do
      it "finds the stealth status" do
        expect(stealthy?(@user.id)).to eq(true)
      end
    end
  end

  context "false stealthy" do
    before do
      @user = FactoryGirl.create(:user, stealth: false)
    end
    describe "stealthy" do
      it "finds the stealth status" do
        expect(stealthy?(@user.id)).to eq(false)
      end
    end
  end

  context "User with a stealthy interest" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @interest = FactoryGirl.create(:interest, id: 2)
      @interestable = FactoryGirl.create(:interestable, user_id: 1, interest_id: 2, id: 10, stealth: true)
    end
    describe "stealthy interest" do
      it "finds the stealth status of the interestable" do
        expect(stealthy_interest?(@user.id, @interest.id)).to eq(true)
      end
    end
  end

  context "User with a non-stealthy interest" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @interest = FactoryGirl.create(:interest, id: 2)
      @interestable = FactoryGirl.create(:interestable, user_id: 1, interest_id: 2, id: 10, stealth: false)
    end
    describe "stealthy interest" do
      it "finds the stealth status of the interestable" do
        expect(stealthy_interest?(@user.id, @interest.id)).to eq(false)
      end
    end
  end

  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @fuser = FactoryGirl.create(:user, email: "fuser@bliply.com", id: 2)
      @ruser = FactoryGirl.create(:user, email: "ruser@bliply.com", id: 3)
    end

    describe "confirmed friendly?" do
      before do
        @confirmed_friend = FactoryGirl.create(:friendship, status: "confirmed", user_id: @user.id, friend_id: @fuser.id, id: 12)
      end
      it "returns true if friendship status is confirmed" do
        expect(friendly?(@user.id, @fuser.id)).to eq true
      end
    end

    describe "requested friendly?" do
      before do
        @requested_friend = FactoryGirl.create(:friendship, status: "requested", user_id: @user.id, friend_id: @ruser.id, id: 10)
      end
      it "returns true if friendship status is requested" do
        expect(friendly?(@user.id, @ruser.id)).to eq true
      end
    end

    describe "pending friendly?" do
      before do
        @pending_friend = FactoryGirl.create(:friendship, status: "pending", user_id: @ruser.id, friend_id: @user.id, id: 11)
      end
      it "returns false if friendship status is pending" do
        expect(friendly?(@ruser.id, @user.id)).to eq false
      end
    end

    describe "blank friendly?" do
      it "returns false if friendship status is blank" do
        expect(friendly?(@fuser.id, @ruser.id)).to eq false
      end
    end
  end

end
