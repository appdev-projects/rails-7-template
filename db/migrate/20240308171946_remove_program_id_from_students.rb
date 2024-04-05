class RemoveProgramIdFromStudents < ActiveRecord::Migration[7.0]
  def change
    remove_column :students, :program_id, :integer
  end
end
