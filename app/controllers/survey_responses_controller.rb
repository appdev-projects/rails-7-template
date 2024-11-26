class SurveyResponsesController < ApplicationController
  def new
    @surveys = Survey.all
  end

  def create
    user = current_user
    total_score = 0

    params.fetch("survey_responses").each do |survey_id, response|
      survey = Survey.find(survey_id.to_i)

      # Define the range value-to-label mapping (must match the frontend logic)
      value_to_label = {
        "0" => "Strongly Disagree",
        "1" => "Disagree",
        "2" => "Neutral",
        "3" => "Agree",
        "4" => "Strongly Agree"
      }

      # Get the label from the numeric value (response)
      label = value_to_label[response]

      # Ensure the scoring_scheme is parsed as a Hash
      scoring_scheme = JSON.parse(survey.scoring_scheme)

      # Fetch the score using the label
      score = scoring_scheme.fetch(label, 0) # Default to 0 if not found

      # Create the survey response record
      SurveyResponse.create({
        user_id: user.id,
        survey_id: survey_id.to_i,
        score: score
      })

      total_score += score
    end

    @total_score = total_score
    render template: "survey_responses/result"
  end
end
