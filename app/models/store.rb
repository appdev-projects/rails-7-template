# == Schema Information
#
# Table name: stores
#
#  id           :bigint           not null, primary key
#  address      :string
#  at_kohls     :boolean
#  store_number :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Store < ApplicationRecord
end
 