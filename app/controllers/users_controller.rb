class UsersController < ApplicationController
  before_action :user_with_role, only: [:create]
  before_action :check_user, only: [:edit, :password]
  before_action :edit_password, only:[:password]
  def edit_password
    flash[:alert]="Not authorized!"
    redirect_to (request.referrer || root_path) unless current_user.id==@user.id
  end
  def managers
    @managers = current_user.organization.managers
    authorize User
  end
  def admins
    @admins = current_user.organization.admins
    authorize User
  end
  def edit
    @organization = current_user.organization
    @user = User.find(params[:id])
    if @user
      redirect_to request.referrer unless @user.organization==@organization
    end
    authorize User
  end
  def password
    @user = User.find(params[:id])
  end
  def post_password
    passwords = user_password_params
    if passwords[:password] == passwords[:password_confirmation]
      @user = User.find(params[:id])
      if @user.update(user_password_params)
        flash[:success]="Password has been updated successfully"
        redirect_to password_user_path(@user)
      else
        flash.now[:alert]="Password not updated"
        render 'password'
      end
    end
  end
  def show
    @user = User.find(params[:id])
  end
  def create
    @password = Random.rand(111111...999999)
    @user.password = @password
    byebug
    if @user.save
      flash[:success]="User #{@user.username} created sucessfully!"
      UserMailer.with(user: @user, password: @password).send_credentials.deliver_later
      redirect_to user_path(@user)
    else
      flash.now[:danger]="User not created!"
      render 'manager' if @user.manager?
      render 'admin' if @user.admin?
    end
  end
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success]="User #{@user.username} updated successfully"
      redirect_to request.referrer
    else
      flash.now[:alert]="User not updated!"
      render 'edit'
    end
  end
  def destroy
    @user = User.find(params[:id])
    @user.destroy
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
  def user_password_params
    params.require(:user).permit(:password, :password_confirmation)
  end
  def check_user
    @user = User.find(params[:id])
    redirect_to request.referrer unless @user.organization == current_user.organization
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