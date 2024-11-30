# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  age                    :integer
#  avatar                 :string
#  bio                    :text
#  budget                 :integer
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_url           :string
#  first_name             :string
#  gender                 :string
#  instagram_url          :string
#  last_name              :string
#  location               :string
#  occupation             :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  survey_score           :integer
#  trust_score            :float            default(0.0)
#  username               :citext
#  video_url              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :sent_feedbacks, class_name: "Review", foreign_key: "sender_id", dependent: :destroy
  has_many  :received_feedbacks, class_name: "Review", foreign_key: "recipient_id", dependent: :destroy
  has_many :survey_responses
  has_one :score

  def pal_name
    "#{first_name} #{last_name}"
  end
end
