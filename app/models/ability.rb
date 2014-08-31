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

    can [:read, :update, :destroy], LectureRecording do |l|
      l.semester.unit_of_study.users.include? user
    end

    if user.is_lecturer?
      can [:new, :create], LectureRecording
    end

    can :manage, UnitOfStudy do |u|
      u.users.include user
    end

    can :manage, Semester do |s|
      s.unit_of_study.users.include? user
    end

    if user.is_admin?
      can :manage, User
      can :manage, LectureRecording
      can :manage, UnitOfStudy
      can :manage, Semester
    end
  end
end
