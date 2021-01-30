class Task < ApplicationRecord
  has_many :task_categories
  has_many :categories, through: :task_categories
  belongs_to :user
  validates :description, presence: true
  accepts_nested_attributes_for :categories
end
