class UsersController < ApplicationController
  # before filter to load the resource into an instance variable and authorize it for every action
  # load_and_authorize_resource

  def verify
    @user = User.find(params[:id])
    @user.update_attribute(:is_verified, true)
    UserMailer.verified_user(@user).deliver
    redirect_to :back
  end

  def unverify
    User.find(params[:id]).update_attribute(:is_verified, false)
    redirect_to :back
  end
  
  # # GET /users
  # # GET /users.json
  # def index
  #   @users = User.all

  #   respond_to do |format|
  #     format.html # index.html.erb
  #     format.json { render json: @users }
  #   end
  # end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end

    authorize! :manage, @user

  end

  def lunch_confirmation
    @user = current_user
  end
  
  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new
    @user.pending_memberships.build

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])

    authorize! :manage, @user
  end

  # POST /users
  # POST /users.json
  def create

    @pending_membership = PendingMembership.new(club_id: params[:user][:pending_membership][:club_id])

    params[:user].delete("pending_membership")

    @user = User.new(params[:user])

    if @user.save
      @pending_membership.user_id = @user.id 
      @pending_membership.user_first_name = @user.first_name
      @pending_membership.user_last_name = @user.last_name
      @pending_membership.user_email = @user.email
      @pending_membership.save
      UserMailer.admin_verification(@user).deliver
      UserMailer.welcome(@user).deliver
      session[:user_id] = @user.id
      
      redirect_to @user, notice: 'User was successfully created.' 
    else
      # needed for render 'new' in case of form errors 
      @user.pending_memberships.build
      render action: "new"
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end


  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
