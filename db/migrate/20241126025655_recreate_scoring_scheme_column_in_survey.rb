class RecreateScoringSchemeColumnInSurvey < ActiveRecord::Migration[7.1]
  def change
    change_column(:surveys, :scoring_scheme, :json, {:using=>"scoring_scheme::JSON"})
  end
end
