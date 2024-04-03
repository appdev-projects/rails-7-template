# == Schema Information
#
# Table name: curriculums
#
#  id          :integer          not null, primary key
#  grade_level :string
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Curriculum < ApplicationRecord
  has_many :programs
end
