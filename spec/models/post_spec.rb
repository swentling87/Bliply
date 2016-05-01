require 'rails_helper'

RSpec.describe Post, type: :model do

  context "user" do
    before do
      @user = FactoryGirl.create(:user, id: 1)
      @location = FactoryGirl.create(:location)
      @interest = FactoryGirl.create(:interest, id: 2)
      @l_post = FactoryGirl.create(:post, id: 5, user_id: @user.id, postable_id: @location.id, postable_type: "Location")
      @i_post = FactoryGirl.create(:post, id: 6, user_id: @user.id, postable_id: @interest.id, postable_type: "Interest")
    end

    describe "location" do
      it "returns the location" do
        expect(@l_post.location).to eq @location
      end
    end
    describe "interest" do
      it "returns the interest" do
        expect(@i_post.interest).to eq @interest
      end
    end
  end
end
