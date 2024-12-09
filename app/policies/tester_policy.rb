class TesterPolicy < ApplicationPolicy

  def welcome?
    true
  end

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
    true
  end

  def skincare?
    true
  end

  def hair?
    true
  end

  def fragrance?
    true
  end

  def manage?
    employee.role.title == "Operations Associate" || employee.admin?
  end
end
