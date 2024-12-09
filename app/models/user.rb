# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  age                    :integer
#  avatar                 :string
#  bio                    :text
#  budget                 :integer
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  facebook_url           :string
#  first_name             :string
#  gender                 :string
#  github_access_token    :string
#  instagram_url          :string
#  last_name              :string
#  location               :string
#  occupation             :string
#  provider               :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  survey_score           :integer
#  trust_score            :integer          default(0)
#  uid                    :string
#  video_url              :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  include User::MetaTaggable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[github]

  before_save :calculate_trust_score

  has_many :sent_messages, class_name: "Message", foreign_key: "sender_id", dependent: :destroy
  has_many :received_messages, class_name: "Message", foreign_key: "recipient_id", dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :instagram_url, format: { with: /\Ahttps:\/\/www\.instagram\.com\// }, allow_blank: true
  validates :facebook_url, format: { with: /\Ahttps:\/\/www\.facebook\.com\// }, allow_blank: true
  validates :video_url, format: { with: /\Ahttps:\/\/www\.youtube\.com\// }, allow_blank: true

  def self.from_omniauth(auth)
    find_or_create_by(provider: auth.provider, uid: auth.uid) do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.github_access_token = auth.credentials.token
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "age", "budget", "gender", "location", "occupation" ]
  end

  def calculate_trust_score
    survey_score = self.survey_score || 0
    video_score = self.video_url.present? ? 10 : 0
    social_score = 0
    social_score += 5 if self.instagram_url.present?
    social_score += 5 if self.facebook_url.present?

    total_score = survey_score + video_score + social_score
    self.trust_score = total_score
  end

  def sent_messages
    Message.where({ sender_id: self.id })
  end

  def received_messages
    Message.where({ recipient_id: self.id })
  end

  def pal_name
    "#{first_name} #{last_name}"
  end
end
