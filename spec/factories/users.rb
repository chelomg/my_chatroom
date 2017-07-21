FactoryGirl.define do
  factory :user do
    id {}
    email { Faker::Internet.email }
    password { 123456 }
    created_at {}
    updated_at {}
  end
end
