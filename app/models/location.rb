class Location < ActiveRecord::Base
  has_many :locationables
  has_many :users, through: :locationables
  has_many :interests, through: :users
end
