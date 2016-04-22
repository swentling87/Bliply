module FriendshipsHelper

  def stealthy(user)
    @friend = User.find(user)
    @friend.stealth ? true : false
  end

end
