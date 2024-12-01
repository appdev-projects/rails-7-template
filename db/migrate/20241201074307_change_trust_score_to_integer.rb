class ChangeTrustScoreToInteger < ActiveRecord::Migration[7.1]
  def change
    change_column :users, :trust_score, :integer, default: 0
  end
end
