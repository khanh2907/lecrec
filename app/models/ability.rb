class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new

    can :manage, User do |u|
      u.id == user.id
    end

    can [:create_discussion,:get_discussions,:render_discussions,:show], LectureRecording

    can :manage, LectureRecording do |l|
      l.user_id == user.id
    end

    if user.is_admin?
      can :manage, User
      can :manage, LectureRecording
      can :manage, UnitOfStudy
    end
  end
end
