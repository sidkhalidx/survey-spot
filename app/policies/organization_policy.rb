class OrganizationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end
  
  def index?
    @user.super_admin?
  end
  def show
    current_user.super_admin?
  end
  def new?
    @user.super_admin?
  end
  def create
    current_user.super_admin?
  end
  def edit
    current_user.super_admin?
  end
  def update
    current_user.super_admin?
  end
  def destroy
    current_user.super_admin?
  end
end