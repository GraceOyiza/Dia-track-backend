FactoryBot.define do
  factory :measure do
    association :user
    title { Faker::Verb.base }
    goal { 200.5 }
    unit { 'kg' }
  end
end
