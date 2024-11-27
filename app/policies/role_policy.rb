class RolePolicy < ApplicationPolicy

  def index?
    employee.admin? 
  end

  def show?
    employee.admin?
  end

  def new?
    employee.admin?
  end

  def create?
    new?
  end

  def edit?
    employee.admin?
  end

  def update?
    edit?
  end

  def destroy?
    employee.admin?
  end
end
