class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum :designation, {
    manager: "manager",
    developer: "developer",
    qa: "qa"
  }

  has_many :user_projects
  has_many :projects, through: :user_projects
  # has_many :tickets
  has_many :tickets_created, class_name: "Ticket", foreign_key: "creator_id"
  has_many :tickets_assigned, class_name: "Ticket", foreign_key: "developer_id"

  validates :email, :encrypted_password, :name, :designation, presence: true
end
