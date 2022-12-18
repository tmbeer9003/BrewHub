FactoryBot.define do
  factory :brewery do
    name { Faker::Lorem.characters(number:10) }
    location { Faker::Number.between(from: 1, to: 10)}
  end
end