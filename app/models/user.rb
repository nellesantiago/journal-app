class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :categories
  has_many :tasks, through: :categories
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
