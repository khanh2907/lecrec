class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_and_belongs_to_many :roles
  has_many :lecture_recordings, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :comments, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def add_role(role_name)
    if roles.find_by_name(role_name).nil? then
      roles << Role.find_by_name(role_name)
      save!
    end
  end

  def remove_role(role_name)
    unless roles.find_by_name(role_name).nil? then
      roles.delete(Role.find_by_name(role_name))
      save!
    end
  end

  def remove_all_roles
    Role.all.each do |role|
      roles.delete(role)
    end
  end

  def is_admin?
  	roles.include?(Role.find_by_name("Administrator"))
  end
end
