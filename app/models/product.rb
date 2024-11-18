# == Schema Information
#
# Table name: products
#
#  id            :bigint           not null, primary key
#  image         :string
#  name          :string
#  sku           :integer
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
end
