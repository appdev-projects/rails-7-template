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
end
