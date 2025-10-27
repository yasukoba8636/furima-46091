FactoryBot.define do
  factory :user do
    nickname              { Faker::Name.initials(number: 2) }
    last_name             { "山田" }
    first_name            { "太郎" }
    email                 { Faker::Internet.email }
    password              { "password123" }
    password_confirmation { password }
  end
end
