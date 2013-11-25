class UserAbility
  include CanCan::Ability

  def initialize(user)
    # guest user
    user ||= User.new
    if user
      can :manage, user
    end
  end

end