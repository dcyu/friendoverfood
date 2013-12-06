class UserMailer < ActionMailer::Base
  default from: "friendoverlunch@gmail.com"

  def welcome(user)
    @user = user
    @url = "http://www.friendoverlunch.com/sign_in"
    mail(to: @user.email, subject: 'Welcome to Friend Over Food!')
  end

  def admin_verification(user)
    @user = user
    mail(to: "dcyu93@gmail.com", subject: 'New Friend Over Food User')
    @url  = "http://www.friendoverlunch.com/sign_in"

  end

  def verified_user(user)
    @user = user
    @url = "http://www.friendoverlunch.com/sign_in"
    mail(to: @user.email, subject: "You're a Verified Baller!")
  end

  def new_lunch_user(lunch)
    @url = "http://www.friendoverlunch.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    mail(to: @user.email, subject: 'New Friend Over Food!')
  end

  def new_lunch_luncher(lunch)
    @url = "http://www.friendoverlunch.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    mail(to: @luncher.email, subject: 'New Friend Over Food!')
  end


end
