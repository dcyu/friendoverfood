class UserMailer < ActionMailer::Base
  default from: "newfriendoverlunch@gmail.com"

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
    @club = Club.find(@lunch.club_id)
    mail(to: @user.email, subject: "Meet #{@luncher.first_name} from #{@club.name}", reply_to: @luncher.email)
  end

  def new_lunch_luncher(lunch)
    @url = "http://www.friendoverlunch.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    @club = Club.find(@lunch.club_id)
    mail(to: @luncher.email, subject: "Meet #{@user.first_name} from #{@club.name}", reply_to: @user.email)
  end


end
