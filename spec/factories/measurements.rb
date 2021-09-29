FactoryBot.define do
  factory :measurement do
    association :measure
    value { 200.5 }
  end
end
