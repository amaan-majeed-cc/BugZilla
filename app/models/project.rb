class Project < ApplicationRecord
  has_many :user_projects, dependent: :delete_all
  has_many :user, through: :user_projects
  has_many :tickets, dependent: :delete_all

  validates :name, presence: true
end
