# == Schema Information
#
# Table name: snapshots
#
#  id         :integer          not null, primary key
#  price      :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :integer
#
class Snapshot < ApplicationRecord
end
