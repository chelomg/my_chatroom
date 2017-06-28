class Conversation < ApplicationRecord
  has_many :messages, dependent: :destroy
  belongs_to :sender, foreign_key: :sender_id, class_name: User
  belongs_to :recipient, foreign_key: :recipient_id, class_name: User

  validates :sender_id, uniqueness: { scope: :recipient_id }

  enum status: {
    niled: nil,
    pending: 0,
    accepted: 1,
    declined: 2,
    blocked: 3
  }

  scope :between, -> (sender_id, recipient_id) do
    where(sender_id: sender_id, recipient_id: recipient_id).or(
      where(sender_id: recipient_id, recipient_id: sender_id)
    )
  end

  scope :my_relation, -> (my_id) do
    where(sender_id: my_id).or(
      where(recipient_id: my_id)
    )
  end

  def self.get(sender_id, recipient_id)
    conversation = between(sender_id, recipient_id).first
    return conversation if conversation.present?

    create(sender_id: sender_id, recipient_id: recipient_id)
  end

  def opposed_user(user)
    user == recipient ? sender : recipient
  end

  def self.find_friends(user)
    result = []
    Conversation.my_relation(user).accepted.each do |conversation|
      if conversation.recipient_id == user.id
        result << conversation.sender_id
      else
        result << conversation.recipient_id
      end
    end
    result
  end
end
