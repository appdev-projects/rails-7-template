# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  age                    :integer
#  avatar                 :string
#  bio                    :text
#  budget                 :integer
#  email                  :string           default(""), not null
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
#  trust_score            :float
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
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
