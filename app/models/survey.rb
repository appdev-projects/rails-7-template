# == Schema Information
#
# Table name: surveys
#
#  id             :bigint           not null, primary key
#  question       :string
#  scoring_scheme :string
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#
class Survey < ApplicationRecord
  has_many  :user_results, class_name: "SurveyResponse", foreign_key: "survey_id", dependent: :destroy
end
