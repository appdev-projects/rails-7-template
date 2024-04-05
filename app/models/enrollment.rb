# == Schema Information
#
# Table name: enrollments
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  program_id :integer          not null
#  student_id :integer          not null
#
# Indexes
#
#  index_enrollments_on_program_id  (program_id)
#  index_enrollments_on_student_id  (student_id)
#
# Foreign Keys
#
#  program_id  (program_id => programs.id)
#  student_id  (student_id => students.id)
#
class Enrollment < ApplicationRecord
  belongs_to :program
  belongs_to :student
end
