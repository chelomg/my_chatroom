require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }
  it '.between' do
  end

  it '.my_relation' do
    user1 = create(:user, id: 1, email: "example1@gmail.com")
    user2 = create(:user, id: 2, email: "example2@gmail.com")
    conversation = create(:conversation, sender_id: user1.id, recipient_id: user2.id)
    expect(Conversation.my_relation(1)).to include(conversation)
  end

  it '.get' do
  end

  it '#opposed_user' do
  end

  it '.find_request_users' do
  end

  it '.find_friends' do
  end
end
