class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable

  has_many :interestables
  has_many :interests, through: :interestables
  has_many :locationables
  has_many :locations, through: :locationables

  has_many :friendships, dependent: :destroy
  has_many :friends, -> { where status: 'confirmed'}, through: :friendships
  has_many :requested_friends, -> {where status: 'requested'}, through: :friendships, source: :friend
  has_many :pending_friends, -> {where status: 'pending'}, through: :friendships, source: :friend

end
