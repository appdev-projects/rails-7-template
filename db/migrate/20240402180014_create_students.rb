class CreateStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :students do |t|
      t.string :first_name
      t.string :last_name
      t.references :school, null: false, foreign_key: true
      t.string :parent_first_name
      t.string :parent_last_name
      t.string :parent_relationship
      t.integer :parent_phone_number
      t.string :emergency_first_name
      t.string :emergency_last_name
      t.integer :emergency_phone
      t.boolean :pre_survey
      t.boolean :post_survey
      t.boolean :interest_survey
      t.boolean :iep_or_504
      t.boolean :progress_report_1
      t.boolean :progress_report_2
      t.boolean :progress_report_3
      t.boolean :progress_report_4

      t.timestamps
    end
  end
end
