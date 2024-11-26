class RecreateScoringSchemeColumnsInSurvey < ActiveRecord::Migration[7.1]
  def up
    remove_column :surveys, :scoring_scheme
    add_column :surveys, :scoring_scheme, :json, default: '{}'
  end

  def down
    remove_column :surveys, :scoring_scheme
    add_column :surveys, :scoring_scheme, :string
  end
end
