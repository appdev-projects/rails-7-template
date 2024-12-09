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
require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with a valid email and password' do
    user = User.new(email: 'john@example.com', password: 'password')
    expect(user).to be_valid
  end

  it 'is invalid without an email and password' do
    user = User.new(email: nil, password: nil)
    expect(user).not_to be_valid
  end
end
