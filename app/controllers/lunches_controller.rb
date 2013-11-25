class LunchesController < ApplicationController
  def create

    if new_lunch_partners.length == 0
      @lunch = current_user.lunches.build()
      if @lunch.save
        redirect_to "/users/#{current_user.id}/lunch_confirmation"
      else
        flash[:error] = "Unable to add luncher."
        redirect_to "/users/#{current_user.id}/lunch_confirmation"      
      end

    elsif new_lunch_partners.length > 0
      open_lunch = Lunch.where(luncher_id: nil, user_id: new_lunch_partners.first.id).first
      open_lunch.luncher_id = current_user.id
      open_lunch.save
      redirect_to user_path(current_user.id)
    end

  end

end
