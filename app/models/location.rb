class Location < ActiveRecord::Base
  has_many :locationables
  has_many :users, through: :locationables
  has_many :interests, through: :users

  has_many :posts, as: :postable, dependent: :destroy

  scope :for_zip_code, -> (zip_code) { where(zip_code: zip_code)}

end
