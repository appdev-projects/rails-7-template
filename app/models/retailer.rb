# == Schema Information
#
# Table name: retailers
#
#  id            :integer          not null, primary key
#  listing_count :integer          default(0)
#  name          :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
class Retailer < ApplicationRecord
  has_many :listings, class_name: "Listing", foreign_key: "retailer_id", dependent: :destroy
end
