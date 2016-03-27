class Location < ActiveRecord::Base
  has_many :users, as: :user_able
  has_many :interests, as: :interest_able
end
