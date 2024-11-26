class ChangeDataTypeForScoringScheme < ActiveRecord::Migration[7.1]
  def change
    change_column_default :surveys, :scoring_scheme, nil
  end
end
