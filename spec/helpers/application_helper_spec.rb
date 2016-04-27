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

end
