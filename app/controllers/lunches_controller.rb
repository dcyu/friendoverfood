class LunchesController < ApplicationController
  def create
    if new_lunch_partners.length == 0
      clubs_with_open_lunches_for_current_user.each do |c|
        lunch = current_user.lunches.build()
        lunch.club_id = c.id
        lunch.save
      end
      redirect_to "/users/#{current_user.id}/lunch_confirmation"

    elsif new_lunch_partners.length > 0
      @open_lunch = Lunch.where(luncher_id: nil, user_id: new_lunch_partners.first.id).first
      @open_lunch.luncher_id = current_user.id
      @open_lunch.save
      LunchMailer.new_lunch_user(@open_lunch).deliver
      LunchMailer.new_lunch_luncher(@open_lunch).deliver
      redirect_to "/users/#{current_user.id}/lunch_confirmation"
    end

  end

end
