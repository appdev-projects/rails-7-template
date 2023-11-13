# == Schema Information
#
# Table name: listings
#
#  id          :integer          not null, primary key
#  url         :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  product_id  :integer
#  retailer_id :integer
#
class Listing < ApplicationRecord
  belongs_to :product, required: true, class_name: "Product", foreign_key: "product_id", counter_cache: true
  
end
