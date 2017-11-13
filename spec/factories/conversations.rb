FactoryGirl.define do
  factory :conversation do
    id { Faker::Number.number(6) }
    recipient_id {}
    sender_id {}
    created_at {}
    updated_at {}
    status {}
    action_id {}
    association :recipient, factory: :user
    association :sender, factory: :user
  end
end
