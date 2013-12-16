class LunchMailer < ActionMailer::Base
  default from: "newfriendoverfood@gmail.com"

  def new_lunch_user(lunch)
    @url = "http://www.friendoverfood.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    @club = @lunch.club
    mail(to: @user.email, subject: "Meet #{@luncher.first_name} from #{@club.name}", reply_to: @luncher.email)
  end

  def new_lunch_luncher(lunch)
    @url = "http://www.friendoverfood.com/sign_in"
    @lunch = lunch
    @user = @lunch.user
    @luncher = User.find(@lunch.luncher_id)
    @club = @lunch.club
    mail(to: @luncher.email, subject: "Meet #{@user.first_name} from #{@club.name}", reply_to: @user.email)
  end
end
