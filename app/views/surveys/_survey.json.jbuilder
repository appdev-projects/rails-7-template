json.extract! survey, :id, :question, :scoring_scheme, :created_at, :updated_at
json.url survey_url(survey, format: :json)
