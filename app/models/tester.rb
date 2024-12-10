# == Schema Information
#
# Table name: testers
#
#  id         :bigint           not null, primary key
#  condition  :string
#  location   :string           default("Backstage"), not null
#  trashed_at :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  product_id :bigint           not null
#  shop_id    :bigint           not null
#
# Indexes
#
#  index_testers_on_product_id  (product_id)
#  index_testers_on_shop_id     (shop_id)
#
# Foreign Keys
#
#  fk_rails_...  (product_id => products.id)
#  fk_rails_...  (shop_id => shops.id)
#
class Tester < ApplicationRecord
  belongs_to :product
  belongs_to :shop

  scope :not_trashed, -> { where(trashed_at: nil) }
  scope :trashed, -> { where.not(trashed_at: nil) }
  scope :not_onstage, -> { where.not(location: "Onstage") }
  scope :onstage, -> { where(location: "Onstage") }
  
  def self.current_shop(employee)
    where(shop_id: employee.shop_id)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["product_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["product"]
  end

  def to_s
    "#{product.name}".truncate(25)
  end
end
