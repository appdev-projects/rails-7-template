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
  belongs_to :listing, required: true, class_name: "Listing", foreign_key: "listing_id"
end
