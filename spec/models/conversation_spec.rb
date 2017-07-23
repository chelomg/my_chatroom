require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }
  describe '.between 找出我跟某人的關係' do
    it 'I am sender' do
      me = create(:user)
      conversation = create(:conversation, sender_id: me.id)
      user1 = conversation.recipient
      expect(Conversation.between(me, user1)).to include(conversation)
      expect(Conversation.between(user1, me)).to include(conversation)
    end
    it 'I am recipient' do
      me = create(:user)
      conversation = create(:conversation, recipient_id: me.id)
      user2 = conversation.sender
      expect(Conversation.between(me, user2)).to include(conversation)
      expect(Conversation.between(user2, me)).to include(conversation)
    end
  end

  it '.my_relation 找出我的所有關係' do
    user = create(:user)
    conversation1 = create(:conversation, recipient_id: user.id)
    conversation2 = create(:conversation, sender_id: user.id)
    expect(Conversation.my_relation(user.id)).to include(conversation1)
    expect(Conversation.my_relation(user.id)).to include(conversation2)
    expect(Conversation.my_relation(user.id).count).to eq(2)
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
