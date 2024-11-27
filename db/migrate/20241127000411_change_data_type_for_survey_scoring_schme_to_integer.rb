class ChangeDataTypeForSurveyScoringSchmeToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :surveys, :scoring_scheme, :integer, using: 'scoring_scheme::integer'
  end
end
