class Friendship < ActiveRecord::Base
  belongs_to :user
  belongs_to :friend, class_name: "User"

  def self.request(user, friend)
      transaction do
        create(user_id: user.id, friend_id: friend.id, status: 'pending')
        create(user_id: friend.id, friend_id: user.id, status: 'requested')
      end
  end

  def self.confirm(user, friend)
    transaction do
      accepted_at = Time.now
      accept_one_side(user, friend, accepted_at)
      accept_one_side(friend, user, accepted_at)
    end
  end

  def self.unfriend(user, friend)
    transaction do
      destroy(find_by_user_id_and_friend_id(user, friend))
      destroy(find_by_user_id_and_friend_id(friend, user))
    end
  end

  private

  def self.accept_one_side(user, friend, accepted_at)
    request = find_by_user_id_and_friend_id(user, friend)
    request.status = 'confirmed'
    request.accepted_at = accepted_at
    request.save!
  end
end
