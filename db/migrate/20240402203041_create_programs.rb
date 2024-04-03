class CreatePrograms < ActiveRecord::Migration[7.0]
  def change
    create_table :programs do |t|
      t.references :user, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.references :curriculum, null: false, foreign_key: true
      t.references :student, null: false, foreign_key: true
      t.string :season
      t.string :days
      t.string :times

      t.timestamps
    end
  end
end
