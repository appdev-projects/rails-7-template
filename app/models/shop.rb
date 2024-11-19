# == Schema Information
#
# Table name: shops
#
#  id          :bigint           not null, primary key
#  address     :string
#  at_kohls    :boolean
#  shop_number :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Shop < ApplicationRecord
  has_many :employees
  has_many :testers
end
