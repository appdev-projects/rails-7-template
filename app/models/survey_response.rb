# == Schema Information
#
# Table name: survey_responses
#
#  id         :bigint           not null, primary key
#  score      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  survey_id  :integer
#  user_id    :integer
#
class SurveyResponse < ApplicationRecord
  belongs_to :user, required: true, class_name: "User", foreign_key: "user_id"
  belongs_to :result, required: true, class_name: "Survey", foreign_key: "survey_id"
end
