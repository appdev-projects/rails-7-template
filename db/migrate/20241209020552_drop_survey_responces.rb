class DropSurveyResponces < ActiveRecord::Migration[7.1]
  def up
    drop_table :survey_responses
  end
end
