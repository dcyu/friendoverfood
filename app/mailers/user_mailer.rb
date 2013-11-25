class UserMailer < ActionMailer::Base
  default from: "ballerlunch@gmail.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://ballerlunch.com/sign_in'
    mail(to: @user.email, subject: 'Welcome to Bosoul!', from: 'welcome@bosoul.com')
  end

  def admin_verification(user)
    @user = user
    mail(to: "dcyu93@gmail.com", subject: 'New Baller Lunch User')
    @url  = 'http://ballerlunch.com/sign_in'

  end

  def new_user_notification(user)
    @user = user
    mail(to: "nishta.boodhoo@gmail.com", subject: "New user #{@user.first_name} #{@user.last_name}")
  end

  def new_lunch(user)
    @user = user
  end

  def new_lunch_inverse(luncher)
    @luncher = luncher
  end

end
