class AddSurveyResponseToUser < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :survey_score, :integer
  end
end
