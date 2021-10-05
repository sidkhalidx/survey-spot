class FormSubmissionPolicy < ApplicationPolicy
  def index?
    @user.admin? || @user.manager?
  end
  def show?
    @user.admin? || @user.manager?
  end
end