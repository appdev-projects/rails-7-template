# == Schema Information
#
# Table name: surveys
#
#  id             :bigint           not null, primary key
#  question       :string
#  scoring_scheme :json
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Survey < ApplicationRecord
  
end
