require 'rails_helper'

RSpec.describe Conversation, type: :model do
  it { should have_many(:messages) }
  it { should belong_to(:sender) }
  it { should belong_to(:recipient) }
  it { should validate_uniqueness_of(:sender_id).scoped_to(:recipient_id) }
  it '.between' do
  end

  it '.my_relation' do
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
