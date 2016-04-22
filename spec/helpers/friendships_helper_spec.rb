require 'rails_helper'


RSpec.describe FriendshipsHelper, type: :helper do

  context "true stealthy" do
    before do
      @user = FactoryGirl.create(:user, stealth: true)
    end
    describe "stealthy" do
      it "finds the stealth status" do
        expect(stealthy(@user)).to eq(true)
      end
    end
  end

  context "false stealthy" do
    before do
      @user = FactoryGirl.create(:user, stealth: false)
    end
    describe "stealthy" do
      it "finds the stealth status" do
        expect(stealthy(@user)).to eq(false)
      end
    end
  end

end
