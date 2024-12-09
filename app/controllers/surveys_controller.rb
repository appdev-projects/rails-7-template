class SurveysController < ApplicationController
  def new
    @surveys = Survey.all
  end

  def create
    @surveys = Survey.all

    user = current_user
    responses = params["responses"]

    total_score = responses.values.map(&:to_i).sum

    current_user.update(survey_score: total_score)

    @total_score = total_score

    render template: "surveys/result"
  end
end
