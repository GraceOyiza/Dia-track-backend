class Measure < ApplicationRecord
  belongs_to :user
  has_many :measurements

  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
end
