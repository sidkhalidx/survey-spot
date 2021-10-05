class UserPolicy < ApplicationPolicy
  def managers?
    @user.admin?
  end
  def admins?
    @user.admin?
  end
  def manager?
    @user.admin?
  end
  def admin?
    @user.admin?
  end
  def edit?
    @user.admin?
  end
end