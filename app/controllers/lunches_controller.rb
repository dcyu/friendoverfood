class LunchesController < ApplicationController
  def create

    if new_lunch_partners.length == 0
      @lunch = current_user.lunches.build()
      @lunch.city = current_user.city
      if @lunch.save
        redirect_to "/users/#{current_user.id}/lunch_confirmation"
      else
        flash[:error] = "Unable to request lunch."
        redirect_to current_user
      end

    elsif new_lunch_partners.length > 0
      @open_lunch = Lunch.where(luncher_id: nil, user_id: new_lunch_partners.first.id).first
      @open_lunch.luncher_id = current_user.id
      @open_lunch.save
      UserMailer.new_lunch_user(@open_lunch).deliver
      UserMailer.new_lunch_luncher(@open_lunch).deliver
      redirect_to "/users/#{current_user.id}/lunch_confirmation"
    end

  end

end
