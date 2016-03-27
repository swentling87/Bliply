class Interest < ActiveRecord::Base
  belongs_to :location_able, polymorphic: true
  belongs_to :user_able, polymorphic: true
end
