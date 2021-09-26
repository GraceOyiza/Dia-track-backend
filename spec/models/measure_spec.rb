require 'rails_helper'

RSpec.describe Measure, type: :model do
  context 'Measure' do
    subject { build :measure }
    context 'User#validations' do
      scenario { should validate_presence_of(:title) }
      scenario { should validate_length_of(:title).is_at_least(3) }
      scenario { should validate_length_of(:title).is_at_most(50) }
    end

    context 'Associations' do
      scenario { should belong_to(:user) }
    end
  end
end
