class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  def welcome_email(user)
    @user = user
    @url  = 'http://bosoul.com/sign_in'
    mail(to: @user.email, subject: 'Welcome to Bosoul!', from: 'welcome@bosoul.com')
  end

  def verification_email
  end

  def new_user_notification(user)
    @user = user
    mail(to: "nishta.boodhoo@gmail.com", subject: "New user #{@user.first_name} #{@user.last_name}")
  end

end
