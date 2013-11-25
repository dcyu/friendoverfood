class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user
  helper_method :current_admin
  helper_method :user_lunches
  helper_method :open_lunches
  helper_method :open_lunchers
  helper_method :previous_lunch_partners
  helper_method :new_lunch_partners


  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_admin
    @current_admin ||= Admin.find(session[:admin_id]) if session[:admin_id]
  end

  def user_lunches
    Lunch.where{ (luncher_id == my{current_user.id}) | (user_id == my{current_user.id}) }
  end

  def open_lunches
    Lunch.where(luncher_id: nil, city: current_user.city)
  end

  def open_lunchers
    open_lunchers = []

    open_lunches.each do |o|
      open_lunchers << o.user
    end
    open_lunchers
  end

  def previous_lunch_partners
    lunch_partners = []

    Lunch.where(luncher_id: current_user.id).each do |f|
      lunch_partners << f.user
    end

    Lunch.where(user_id: current_user.id).each do |f|
      lunch_partners << User.where(id: f.luncher_id).first
    end

    lunch_partners
  end

  def new_lunch_partners
    new_lunch_partners = open_lunchers - previous_lunch_partners
  end
  
end
