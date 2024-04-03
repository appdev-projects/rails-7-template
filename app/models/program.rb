# == Schema Information
#
# Table name: programs
#
#  id            :integer          not null, primary key
#  days          :string
#  season        :string
#  times         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  curriculum_id :integer          not null
#  school_id     :integer          not null
#  student_id    :integer          not null
#  user_id       :integer          not null
#
# Indexes
#
#  index_programs_on_curriculum_id  (curriculum_id)
#  index_programs_on_school_id      (school_id)
#  index_programs_on_student_id     (student_id)
#  index_programs_on_user_id        (user_id)
#
# Foreign Keys
#
#  curriculum_id  (curriculum_id => curriculums.id)
#  school_id      (school_id => schools.id)
#  student_id     (student_id => students.id)
#  user_id        (user_id => users.id)
#
class Program < ApplicationRecord
  has_many :users
  belongs_to :school
  belongs_to :curriculum
  has_many :students
end
