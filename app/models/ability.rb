class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User do |u|
      u.id == user.id
    end

    if user.is_admin?
      can :manage, User
    end
  end
end
