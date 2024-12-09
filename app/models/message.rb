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

  def sender
    matching_users = User.where({ id: self.sender_id })
    matching_users.at(0)
  end

  def recipient
    matching_users = User.where({ id: self.recipient_id })
    matching_users.at(0)
  end
end
