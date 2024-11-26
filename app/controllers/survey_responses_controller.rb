class SurveyResponsesController < ApplicationController
  def new
    @surveys = Survey.all
  end

  def create
    user = current_user
    total_score = 0

    params.fetch("survey_responses").each do |survey_id, response|
      survey = Survey.find(survey_id.to_i)

      # Ensure the scoring_scheme is parsed as a Hash
      scoring_scheme = JSON.parse(survey.scoring_scheme)

      # Fetch the score, handle the case where the response key is missing
      score = scoring_scheme.fetch(response, 0) # Default to 0 if not found

      SurveyResponse.create({
        :user_id => user.id,
        :survey_id => survey_id.to_i,
        :score => score,
      })

      total_score += score
    end

    @total_score = total_score
    render({ :template => "survey_responses/result" })
  end
end
