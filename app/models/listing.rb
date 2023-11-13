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
  belongs_to :retailer, required: true, class_name: "Retailer", foreign_key: "retailer_id", counter_cache: true
  has_many  :snapshots, class_name: "Snapshot", foreign_key: "listing_id", dependent: :destroy
end
