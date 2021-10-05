class FormPolicy < ApplicationPolicy

  def index?
    @user.admin? || @user.manager?
  end
  def new?
    @user.admin?
  end
  def edit?
    @user.admin?
  end
  def emails?
    @user.admin?
  end
  def destroy?
    @user.admin?
  end
end