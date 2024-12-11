# == Schema Information
#
# Table name: employees
#
#  id                     :bigint           not null, primary key
#  admin                  :boolean          default(FALSE), not null
#  email                  :string           default(""), not null
#  employee_number        :integer          not null
#  encrypted_password     :string           default(""), not null
#  first_name             :string
#  last_name              :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  role_id                :bigint
#  shop_id                :bigint
#
# Indexes
#
#  index_employees_on_employee_number       (employee_number) UNIQUE
#  index_employees_on_reset_password_token  (reset_password_token) UNIQUE
#  index_employees_on_role_id               (role_id)
#  index_employees_on_shop_id               (shop_id)
#
class Employee < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :employee_number, presence: true, uniqueness: true

  # ASSOCIATIONS 
  belongs_to :role
  belongs_to :shop

  def admin?
    admin
  end
end
