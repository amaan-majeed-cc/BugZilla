class Project < ApplicationRecord
  has_many :user_projects
  has_many :user, through: :user_projects
  has_many :tickets

  validates :name, presence: true
end
