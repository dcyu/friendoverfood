class UserMailer < ActionMailer::Base
  default from: "newfriendoverfood@gmail.com"

  def welcome(user)
    @user = user
    @url = "http://www.friendoverfood.com/sign_in"
    mail(to: @user.email, subject: 'Welcome to Friend Over Food!')
  end

  def admin_verification(user)
    @user = user
    mail(to: "dcyu93@gmail.com", subject: 'New Friend Over Food User')
    @url  = "http://www.friendoverfood.com/sign_in"

  end

  def verified_user(user)
    @user = user
    @url = "http://www.friendoverfood.com/sign_in"
    mail(to: @user.email, subject: "You're Verified!")
  end

  def invitation(pending_membership)
    @url = "http://www.friendoverfood.com"
    @sign_up_url = "http://www.friendoverfood.com/sign_in"
    @pending_membership = pending_membership
    @inviter = User.find(@pending_membership.inviter_user_id)
    @club = Club.find(@pending_membership.club_id)
  end


end
