# == Schema Information
#
# Table name: schools
#
#  id         :integer          not null, primary key
#  address    :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class School < ApplicationRecord
  belongs_to :user
  has_many :programs
  has_many :students
  has_many :curriculums
end
