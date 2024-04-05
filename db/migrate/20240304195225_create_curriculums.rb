class CreateCurriculums < ActiveRecord::Migration[7.0]
  def change
    create_table :curriculums do |t|
      t.string :name
      t.string :grade_level

      t.timestamps
    end
  end
end
