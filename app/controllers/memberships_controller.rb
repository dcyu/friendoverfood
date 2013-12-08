class MembershipsController < ApplicationController

  def make_admin
    @membership = Membership.find(params[:id])
    @membership.is_admin = true
    @membership.save
    redirect_to club_path(@membership.club)    
  end

  def destroy
    @membership = Membership.find(params[:id])
    @club = @membership.club
    @membership.destroy

    flash[:notice] = "#{@membership.user.first_name} #{@membership.user.last_name} has been removed from #{@club.name}"

    redirect_to @club
  end
end
