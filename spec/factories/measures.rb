FactoryBot.define do
  factory :measure do
    association :user
    title { Faker::Verb.base }
  end
end
