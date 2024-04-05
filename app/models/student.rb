# == Schema Information
#
# Table name: students
#
#  id                   :integer          not null, primary key
#  emergency_first_name :string
#  emergency_last_name  :string
#  emergency_phone      :integer
#  first_name           :string
#  iep_or_504           :boolean
#  interest_survey      :boolean
#  last_name            :string
#  parent_first_name    :string
#  parent_last_name     :string
#  parent_phone_number  :integer
#  parent_relationship  :string
#  post_survey          :boolean
#  pre_survey           :boolean
#  progress_report_1    :boolean
#  progress_report_2    :boolean
#  progress_report_3    :boolean
#  progress_report_4    :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  school_id            :integer          not null
#
# Indexes
#
#  index_students_on_school_id  (school_id)
#
# Foreign Keys
#
#  school_id  (school_id => schools.id)
#
class Student < ApplicationRecord
  has_many :enrollments
  has_many :programs, through: :enrollments
  belongs_to :school
 
  def full_name
    "#{first_name} #{last_name}" 
  end

end
