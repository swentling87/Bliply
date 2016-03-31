class Interest < ActiveRecord::Base

  has_many :interestables
  has_many :users, through: :interestables
  has_many :locations, through: :users
end
