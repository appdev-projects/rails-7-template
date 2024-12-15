# == Schema Information
#
# Table name: messages
#
#  id           :bigint           not null, primary key
#  body         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  recipient_id :integer
#  sender_id    :integer
#
class Message < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "sender_id"
  belongs_to :recipient, required: true, class_name: "User", foreign_key: "recipient_id"
  scope :for_user, ->(user_id) { where("sender_id = ? OR recipient_id = ?", user_id, user_id) }
  scope :latest_messages_for_user, ->(user_id) {
    for_user(user_id)
      .group_by { |message| [ message.sender_id, message.recipient_id ].sort }
      .map { |_, messages| messages.max_by { |message| message.created_at } }
  }


  def sender
    matching_user = User.find(self.sender_id)
  end

  def recipient
    matching_user = User.find(self.recipient_id)
  end
end
