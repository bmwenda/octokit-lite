FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    username { Faker::Name.first_name }
    email { Faker::Internet.email }
    password { 'pass' }
  end
end
