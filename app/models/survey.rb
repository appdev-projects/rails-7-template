# == Schema Information
#
# Table name: surveys
#
#  id             :bigint           not null, primary key
#  question       :string
#  scoring_scheme :integer          default(1)
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Survey < ApplicationRecord
end
