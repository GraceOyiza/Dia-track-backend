require 'rails_helper'

RSpec.describe Measurement, type: :model do
  context 'Measure' do
    subject { build :measurement }
    context 'User#validations' do
      scenario { should validate_presence_of(:value) }
      scenario { should validate_numericality_of(:value).is_greater_than(0.0) }
    end

    context 'Associations' do
      scenario { should belong_to(:measure) }
    end
  end
end
