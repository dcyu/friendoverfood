class UserMailer < ActionMailer::Base
  default from: "newfriendoverfood@gmail.com"

  def welcome(user)
    @user = user
    @url = "http://www.friendoverfood.com/sign_in"
    mail(to: @user.email, subject: 'Welcome to Friend Over Food!')
  end

  def admin_verification(membership)
    @pending_membership = membership
    @pending_member = @pending_membership.user
    @club = @pending_membership.club
    @admins = Membership.where(club_id: @club, is_admin: true).map{|m| m.user}
    mail(to: @admins.map{|a| a.email}, subject: "#{@club.name} Membership Request")
    # mail(to: Proc.new {@admins.map{|a| a.email}}, subject: "#{@club.name} Membership Request")
    @url = "http://www.friendoverfood.com/sign_in"
  end

  def verified_membership(membership)
    @user = membership.user
    @club = membership.club
    @url = "http://www.friendoverfood.com/sign_in"
    mail(to: @user.email, subject: "You're Verified!")
  end

  def invitation(pending_membership)
    @url = "http://www.friendoverfood.com"
    @sign_up_url = "http://www.friendoverfood.com/sign_up"
    @pending_membership = pending_membership
    @inviter = User.find(@pending_membership.inviter_user_id)
    @club = Club.find(@pending_membership.club_id)
    mail(to: @pending_membership.user_email, subject: "You've been invited to join #{@club.name}!")
  end

  def invitation_existing_member(membership)
    @new_member = membership.user
    @url = "http://www.friendoverfood.com"
    @sign_up_url = "http://www.friendoverfood.com/sign_in"
    @inviter = User.find(membership.inviter_user_id)
    @club = Club.find(membership.club_id)
    mail(to: @new_membership.email, subject: "You've been added to #{@club.name}!")
  end


end
