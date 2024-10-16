class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum designation: {
    manager: "manager",
    developer: "developer",
    qa: "qa"
  }

  validates :email, :encrypted_password, :designation, :name, presence: true

  has_many :user_projects
  has_many :project, through: :user_projects
end
