class Measurement < ApplicationRecord
  belongs_to :measure

  validates :value, presence: true, numericality: { only_foat: true }
  validates :value, numericality: { greater_than: 0.0, message: 'must be greater than 0.0' }
end
