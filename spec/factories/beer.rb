FactoryBot.define do
  factory :beer do
    association :beer_style
    association :brewery
    id { Faker::Number.unique.between(from: 1)}
    name { Faker::Lorem.characters(number:10) }
  end
end