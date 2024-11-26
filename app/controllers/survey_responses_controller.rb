class SurveyResponsesController < ApplicationController
  def new
    @surveys = Survey.all
  end

  def create
    user = current_user
    total_score = 0

    params.fetch("survey_responses").each do |survey_id, score|
      SurveyResponse.create({
        :user_id => user.id,
        :survey_id => survey_id.to_i,
        :score => score.to_i
      })
      total_score += score.to_i
    end

    @total_score = total_score
    render({ :template => "survey_responses/result" })
  end
end
