class UsersController < ApplicationController
  before_action :user_with_role, only: [:create]
  def managers
    @managers = current_user.organization.managers
    authorize User
  end
  def admins
    @admins = current_user.organization.admins
    authorize User
  end
  def edit
    @user = User.find(params[:id])
    authorize User
  end
  def create
    @password = Random.rand(111111...999999)
    @user.password = @password
    if @user.save
      UserMailer.with(user: @user, password: @password).send_credentials.deliver_later
    end
  end
  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to request.referrer
  end
  def manager
    @user = current_user.organization.managers.build(role:'manager')
    authorize User
  end
  def admin
    @user = current_user.organization.admins.build(role:'admin')
    authorize User
  end

  def user_params
    params.require(:user).permit(:username, :email)
  end

  def user_with_role
    @user = current_user.organization.managers.build(user_params)
    if request.referrer.include? 'manager'
      @user.role='manager'
    elsif request.referrer.include? 'admin'
      @user.role='admin'
    end
  end
end