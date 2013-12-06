class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    admin = Admin.find_by_email(params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    elsif admin && admin.authenticate(params[:password])
      session[:admin_id] = admin.id
      redirect_to admin_path(admin.id)
    else
      flash[:notice] = "Invalid email or password"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_id] = nil
    redirect_to root_url, :notice => "Logged out!"
  end
  
end
