class PendingMembershipsController < ApplicationController
  def new
    @club = Club.find(params[:club])
    @pending_membership = PendingMembership.new
  end

  def create
    @pending_membership = PendingMembership.new(params[:pending_membership])
    @membership = Membership.new
    @invited_user = User.where(email: @pending_membership.user_email).first

    if @invited_user
      @membership.user_id = @invited_user.id
      @membership.club_id = @pending_membership.club_id
      @membership.save
      UserMailer.invitation_existing_member(@pending_membership).deliver
      flash[:notice] = "#{@invited_user.first_name} #{@invited_user.last_name} added to #{@membership.club.name}"
      redirect_to new_pending_membership_path(:club => @membership.club.id)
    else
      if @pending_membership.save
        UserMailer.invitation(@pending_membership).deliver
        flash[:notice] = "#{@pending_membership.user_first_name} #{@pending_membership.user_last_name} has been invited to join #{@pending_membership.club.name} and Friend Over Food."
        redirect_to new_pending_membership_path(:club => @pending_membership.club_id)
      else
        flash[:notice] = "Invalid Email Address"
        redirect_to new_pending_membership_path(:club => @pending_membership.club_id)        
      end
    end
  end
end