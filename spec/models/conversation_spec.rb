require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }

  describe '.between 找出我跟某人的關係' do
    let(:me) { create(:user) }
    it 'I am sender' do
      conversation = create(:conversation, sender_id: me.id)
      user1 = conversation.recipient
      expect(Conversation.between(me, user1)).to include(conversation)
      expect(Conversation.between(user1, me)).to include(conversation)
    end
    it 'I am recipient' do
      conversation = create(:conversation, recipient_id: me.id)
      user2 = conversation.sender
      expect(Conversation.between(me, user2)).to include(conversation)
      expect(Conversation.between(user2, me)).to include(conversation)
    end
  end

  let(:user1) { create(:user) }
  let(:user2) { create(:user) }
  let(:user3) { create(:user) }

  it '.my_relation 找出我的所有關係' do
    conversation1 = create(:conversation, recipient_id: user1.id)
    conversation2 = create(:conversation, sender_id: user1.id)
    expect(Conversation.my_relation(user1.id)).to include(conversation1)
    expect(Conversation.my_relation(user1.id)).to include(conversation2)
    expect(Conversation.my_relation(user1.id).count).to eq(2)
  end

  it '.get' do
    #first time
    expect { Conversation.get(user1.id, user2.id) }.to change { Conversation.count }.by(1)
    #second time (already existed)
    expect { Conversation.get(user1.id, user2.id) }.to change { Conversation.count }.by(0)
  end

  it '#opposed_user' do
    conversation = create(:conversation, recipient_id: user1.id, sender_id: user2.id)
    expect(conversation.opposed_user(user1)).to eq(user2)
    expect(conversation.opposed_user(user2)).to eq(user1)
  end

  describe 'find user using conversation status' do
    let!(:conversation1) { create(:conversation, status: 0, action_id: user1.id, sender_id: user1.id, recipient_id: user2.id) }
    let!(:conversation2) { create(:conversation, status: 0, action_id: user2.id, sender_id: user2.id, recipient_id: user1.id) }
    let!(:conversation3) { create(:conversation, status: 1, action_id: user2.id, sender_id: user3.id, recipient_id: user2.id) }
    let!(:conversation4) { create(:conversation, status: 1, action_id: user1.id, sender_id: user3.id, recipient_id: user1.id) }

    it '.find_request_users' do
      expect(Conversation.find_request_users(user1).count).to eq(1)
      expect(Conversation.find_request_users(user1)).to include(conversation2.action_id)
      expect(Conversation.find_request_users(user2).count).to eq(1)
      expect(Conversation.find_request_users(user2)).to include(conversation1.action_id)
    end

    it '.find_friends' do
      expect(Conversation.find_friends(user1).count).to eq(1)
      expect(Conversation.find_friends(user1)).to include(user3.id)
      expect(Conversation.find_friends(user2).count).to eq(1)
      expect(Conversation.find_friends(user2)).to include(user3.id)
    end
  end
end
