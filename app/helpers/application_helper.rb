module ApplicationHelper

  def stealthy?(user_id)
    @user = User.find(user_id)
    @user.stealth ? true : false
  end

  def stealthy_interest?(user_id, interest_id)
    @interestable = Interestable.find_by_user_id_and_interest_id(user_id, interest_id)
    @interestable.stealth ? true : false
  end

end
