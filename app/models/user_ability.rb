class UserAbility
  include CanCan::Ability

  def initialize(user)
    # guest user
    user ||= User.new
    if Membership.where(user_id: user, is_admin: true).length > 0
    end

    if user
      can :manage, user
      can :manage, Membership.where(user_id: user, is_admin: true).map{|m| m.club}
      can :read, Club
    end

  end

end