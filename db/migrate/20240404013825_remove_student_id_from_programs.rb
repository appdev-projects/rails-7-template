class RemoveStudentIdFromPrograms < ActiveRecord::Migration[7.0]
  def change
    remove_column :programs, :student_id, :integer
  end
end
