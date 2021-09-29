FactoryBot.define do
  factory :reading do
    association :user
    fasting { Faker::Number.decimal(l_digits: 2) }
    after_meal { Faker::Number.decimal(l_digits: 2) }
    bp { Faker::Number.decimal(l_digits: 2) }
    date { Faker::Date.forward(days: 23) }
  end
end
