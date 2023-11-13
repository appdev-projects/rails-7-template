# == Schema Information
#
# Table name: products
#
#  id             :integer          not null, primary key
#  description    :string
#  image          :string
#  listings_count :integer          default(0)
#  name           :string
#  product_volume :integer
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Product < ApplicationRecord
end
