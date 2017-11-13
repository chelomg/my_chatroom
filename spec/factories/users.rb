FactoryGirl.define do
  factory :user do
    id { Faker::Number.number(6) }
    email { Faker::Internet.email }
    password { 123456 }
    created_at {}
    updated_at {}
  end
end
