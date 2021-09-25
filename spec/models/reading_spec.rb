require 'rails_helper'

RSpec.describe Reading, type: :model do
  context 'Model' do
    subject { build :reading }
    context 'User#validations' do
      scenario { should validate_presence_of(:fasting) }

      scenario { should validate_presence_of(:after_meal) }

      scenario { should validate_presence_of(:bp) }

      scenario { should validate_presence_of(:date) }

      scenario { should be_valid }
    end

    context 'Associations' do
      scenario { should belong_to(:user) }
    end
  end
end
