module TesterQueries
  extend ActiveSupport::Concern

  included do
    scope :not_trashed, -> { where(trashed_at: nil) }
    scope :trashed, -> { where.not(trashed_at: nil) }
    scope :not_onstage, -> { where.not(location: "Onstage") }
    scope :onstage, -> { where(location: "Onstage") }
  end

  class_methods do
    def current_shop(employee)
      where(shop_id: employee.shop_id)
    end

    def by_department(employee, department_name)
      department = Department.find_by(name: department_name)
      current_shop(employee).not_trashed.not_onstage.where(
        product_id: Product.where(department_id: department.id).pluck(:id)
      ).order(created_at: "DESC")
    end
  end
end
