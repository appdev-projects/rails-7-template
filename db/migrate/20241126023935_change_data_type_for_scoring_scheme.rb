class ChangeDataTypeForScoringScheme < ActiveRecord::Migration[7.1]
  def change
    change_column :surveys, :scoring_scheme, :text
  end
end
