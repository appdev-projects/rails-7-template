class ProgramStudents < ActiveRecord::Migration[7.0]
  def change
      create_table :programs_students, id: false do |t|
        t.belongs_to :program
        t.belongs_to :student
        t.timestamps
      end
  end
end
