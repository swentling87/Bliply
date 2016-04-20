require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the UsersHelper. For example:
#
# describe UsersHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe UsersHelper, type: :helper do
  describe "genderer" do
    it "labels the gender" do
      expect(genderer(1)).to eq("Male")
    end
    it "labels the gender" do
      expect(genderer(2)).to eq("Female")
    end
    it "labels the gender" do
      expect(genderer(3)).to eq("Other")
    end
  end
end
