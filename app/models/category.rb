class Category < ApplicationRecord
  belongs_to :user
  has_many :tasks, dependent: :destroy
  validates :title, presence: true
  validates_uniqueness_of :title, message: "already exists"
end
