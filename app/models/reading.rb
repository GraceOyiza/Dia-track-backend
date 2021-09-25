class Reading < ApplicationRecord
  belongs_to :user

  validates :fasting, :bp, :after_meal, :date, presence: true
end
