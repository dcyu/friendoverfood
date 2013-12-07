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
    Lunch.where(luncher_id: nil, club_id: current_user.clubs)
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

  def clubs_with_open_lunches_for_current_user
    clubs_with_open_lunches = current_user.lunches.where(luncher_id: nil, user_id: current_user.id).map {|lunch| lunch.club}

    current_user.clubs - clubs_with_open_lunches
  end
  # Cancan errors
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = "Access denied."
    return root_url
  end

  # overriding CanCan::ControllerAdditions

  def current_account
    if current_user
      current_account = current_user
    elsif current_admin
      current_account = current_admin
    end
  end

  def current_ability
    if current_account.kind_of?(Admin)
      @current_ability ||= AdminAbility.new(current_account)
    else
      @current_ability ||= UserAbility.new(current_account)
    end
  end
  
end
