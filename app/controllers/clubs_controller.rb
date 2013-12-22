class ClubsController < ApplicationController
  # GET /clubs
  # GET /clubs.json

  def approve_membership
    @pm = PendingMembership.find(params[:id])
    @club = @pm.club
    m = Membership.new
    m.club_id = @pm.club_id
    m.user_id = @pm.user_id

    if m.save
      @pm.destroy
      redirect_to club_path(@club)
    end
  end

  def deny_membership
    @pm = PendingMembership.find(params[:id])
    @pm.destroy
    redirect_to club_path(@club)
  end

  def join
    @club = Club.find(params[:id])
    
    if current_user
      m = PendingMembership.new
      m.user_id = current_user.id
      # Needed since some PendingMemberships don't have User IDs yet and this keeps view code consistent
      m.user_first_name = current_user.first_name
      m.user_last_name = current_user.last_name
      m.user_email = current_user.email
      m.club_id = @club.id
      m.save
      flash[:notice] = "Request to join #{@club.name} submitted. You'll be notified once your request is approved."
      redirect_to user_path(current_user.id)
    else
      flash[:notice] = 'Must be signed in to join club.'
      redirect_to clubs_path
    end
  end

  def index
    @clubs = Club.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clubs }
    end
  end

  # GET /clubs/1
  # GET /clubs/1.json
  def show
    @club = Club.find(params[:id])
    @current_user_membership = Membership.where(club_id: @club, user_id: current_user).first

    if current_user.clubs.include? @club && @current_user_membership.is_admin == true
      authorize! :manage, @club
    else
      authorize! :read, @club
    end
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @club }
    end
  end

  # GET /clubs/new
  # GET /clubs/new.json
  def new
    @club = Club.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @club }
    end
  end

  # GET /clubs/1/edit
  def edit
    @club = Club.find(params[:id])
  end

  # POST /clubs
  # POST /clubs.json
  def create
    @club = Club.new(params[:club])

    respond_to do |format|
      if @club.save
        @membership = Membership.new
        @membership.club_id = @club.id
        @membership.user_id = current_user.id
        @membership.is_admin = true
        @membership.save
        format.html { redirect_to @club, notice: 'Club was successfully created.' }
        format.json { render json: @club, status: :created, location: @club }
      else
        format.html { render action: "new" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clubs/1
  # PUT /clubs/1.json
  def update
    @club = Club.find(params[:id])

    respond_to do |format|
      if @club.update_attributes(params[:club])
        format.html { redirect_to @club, notice: 'Club was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @club.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clubs/1
  # DELETE /clubs/1.json
  def destroy
    @club = Club.find(params[:id])
    @club.destroy

    respond_to do |format|
      format.html { redirect_to clubs_url }
      format.json { head :no_content }
    end
  end
end
