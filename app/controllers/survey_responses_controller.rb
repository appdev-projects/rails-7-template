class SurveyResponsesController < ApplicationController
  def new
    @surveys = Survey.all
  end

  def create
    user = current_user
    responses = params["responses"]

    total_score = responses.values.map(&:to_i).sum

    current_user.update(survey_score: total_score)

    @total_score = total_score

    render template: "survey_responses/result"
  end
end
