FactoryBot.define do
  factory :post do
    association :beer
    association :member
    content { Faker::Lorem.characters(number:30) }
    serving_style { 1 }
    is_closed { false }
  end
end