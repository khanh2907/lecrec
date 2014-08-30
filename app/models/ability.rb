class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User do |u|
      u.id == user.id
    end

    can :manage, LectureRecording do |l|
      l.user_id == user.id
    end

    can :read, LectureRecording do |l|
      l.semester.users.include user
    end

    if user.is_admin?
      can :manage, User
      can :manage, LectureRecording
      can :manage, UnitOfStudy
    end
  end
end
