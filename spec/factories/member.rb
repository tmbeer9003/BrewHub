FactoryBot.define do
  factory :member do
    sequence(:email) { |n| "tester#{n}@test.com" }
    password { Faker::Lorem.characters(number:10) }
    account_name { Faker::Lorem.characters(number:10) }
    display_name { Faker::Lorem.characters(number:10) }
    date_of_birth { "1980-01-01" }
    status { 0 }
  end
end