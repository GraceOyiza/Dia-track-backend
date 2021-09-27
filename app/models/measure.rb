class Measure < ApplicationRecord
  belongs_to :user
  has_many :measurements

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :goal, presence: true, numericality: { greater_than: 0.0 }
  validates :unit, presence: true, length: { minimum: 2, maximum: 10 }
end
