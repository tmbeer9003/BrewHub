FactoryBot.define do
  factory :beer_style do
    name { Faker::Lorem.characters(number:10) }
    category { 0 }
  end
end