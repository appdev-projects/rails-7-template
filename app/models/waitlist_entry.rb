# == Schema Information
#
# Table name: waitlist_entries
#
#  id         :integer          not null, primary key
#  email      :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class WaitlistEntry < ApplicationRecord
  validates :email, presence: true
  validates :name, presence: true
end
