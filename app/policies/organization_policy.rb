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
    @user.super_admin?
  end
  def new?
    @user.super_admin?
  end
  def create
    @user.super_admin?
  end
  def edit
    @user.super_admin?
  end
  def update
    @user.super_admin?
  end
  def destroy
    @user.super_admin?
  end
end