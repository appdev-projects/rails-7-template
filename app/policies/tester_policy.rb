class TesterPolicy < ApplicationPolicy

  def index?
    true
  end

  def show?
    employee.admin? == false
  end

  def new?
    employee.admin? == false
  end

  def create?
    new?
  end

  def edit?
    employee.admin? == false
  end

  def update?
    employee.admin? == false
  end

  def destroy?
    employee.admin? == false
  end

  def trash?
    employee.role.title = "Operations Associate"
  end

  def trashed?
    employee.role.title = "Operations Associate" || employee.admin?
  end

  def makeup?
    employee.admin? == false
  end

  def skincare?
    employee.admin? == false
  end

  def hair?
    employee.admin? == false
  end

  def fragrance?
    employee.admin? == false
  end

  def manage?
    employee.role.title == "Operations Associate"
  end
end
