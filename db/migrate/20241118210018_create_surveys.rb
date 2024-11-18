class CreateSurveys < ActiveRecord::Migration[7.1]
  def change
    create_table :surveys do |t|
      t.string :question
      t.integer :scoring_scheme, default: 1

      t.timestamps
    end
  end
end
