class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  has_and_belongs_to_many :roles
  has_many :lecture_recordings, dependent: :destroy
  has_many :discussions, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def is_admin?
  	roles.include?(Role.find_by_name("Administrator"))
  end
end
