module ApplicationHelper

  def stealthy?(user_id)
    @user = User.find(user_id)
    @user.stealth ? true : false
  end

  def stealthy_interest?(user_id, interest_id)
    @interestable = Interestable.find_by_user_id_and_interest_id(user_id, interest_id)
    @interestable.stealth ? true : false
  end

  def friendly?(user_id, other_id)
    @friendships = (User.find(user_id)).friendships.where(status: "confirmed")
    @r_friendships = (User.find(user_id)).friendships.where(status: "requested")
    @friendly = @friendships.where(friend_id: other_id)
    @r_friendly = @r_friendships.where(friend_id: other_id)
    if @friendships.count > 0
      @friendly.count > 0 ? true : false
    elsif @r_friendships.count > 0
      @r_friendly.count > 0 ? true : false
    else
      false
    end
  end

end
