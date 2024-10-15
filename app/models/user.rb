class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum designation: {
    manager: 'manager',
    developer: 'developer',
    qa: 'qa'
  }

  validates :email, :encrypted_password, :designation, :name, presence: true
end
