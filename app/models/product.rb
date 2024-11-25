# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  image         :string
#  name          :string
#  sku           :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  brand_id      :bigint           not null
#  department_id :bigint           not null
#
# Indexes
#
#  index_products_on_brand_id       (brand_id)
#  index_products_on_department_id  (department_id)
#
# Foreign Keys
#
#  fk_rails_...  (brand_id => brands.id)
#  fk_rails_...  (department_id => departments.id)
#
class Product < ApplicationRecord
  belongs_to :brand
  belongs_to :department
  has_many :testers

  validates :sku, uniqueness: true

  scope :makeup, -> { where(department_id => Department.makeup) }
  scope :skincare, -> { where(department_id => Department.skincare) }
  scope :hair, -> { where(department_id => Department.hair) }
  scope :fragrance, -> { where(department_id => Department.fragrance) }

  def self.ransackable_attributes(auth_object = nil)
    ["name", "sku"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["testers"]
  end
end
