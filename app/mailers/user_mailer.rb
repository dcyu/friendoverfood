class UserMailer < ActionMailer::Base
  default from: "ballerlunch@gmail.com"

  def welcome(user)
    @user = user
    @url = "http://www.ballerlunch.com/sign_in"
    mail(to: @user.email, subject: 'Welcome to Baller Lunch!')
  end

  def admin_verification(user)
    @user = user
    mail(to: "dcyu93@gmail.com", subject: 'New Baller Lunch User')
    @url  = "http://www.ballerlunch.com/sign_in"

  end

  def verified_user(user)
    @user = user
    @url = "http://www.ballerlunch.com/sign_in"
    mail(to: @user.email, subject: "You're a Verified Baller!")
  end

  def new_lunch_user(lunch)
    @url = "http://www.ballerlunch.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    mail(to: @user.email, subject: 'New Baller Lunch!')
  end

  def new_lunch_luncher(lunch)
    @url = "http://www.ballerlunch.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    mail(to: @luncher.email, subject: 'New Baller Lunch!')
  end


end
