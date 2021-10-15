class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.search(params[:search])
    authorize @organizations
  end
  def new
    @organization = current_user.organizations.build
    @admin = @organization.admins.build
    authorize @organization
  end
  def create
    @organization = current_user.organizations.build(organization_params)
    @admin = @organization.admins.first
    @organization.admins[0].role="admin"
    @password = @organization.admins[0].password
    if @organization.save
      flash[:success]="Organization Created Successfully!!"
      UserMailer.with(user: @organization.admins[0], password: @password).send_credentials.deliver_later
      redirect_to user_organizations_path
    else
      flash.now[:danger] = 'There are Error(s) in form!'
      render 'new'
    end
  end
  def show
    @organization = Organization.find(params[:id])
    authorize @organization
  end
  def edit
    @organization = Organization.find(params[:id])
    authorize @organization
  end
  def update
    @organization = Organization.find(params[:id])
    if @organization.update(organization_params)
      flash[:success]="Organization Updated Successfully!!"
      redirect_to user_organization_path(current_user, @organization)
    else
      flash.now[:danger]="Some Error occured"
      render 'edit'
    end
  end
  def destroy
    @organization = Organization.find(params[:id])
    authorize @organization
    if @organization.destroy
      flash[:success]="Organization Deleted Successfully!!"
      redirect_to user_organizations_path(current_user)
    end
  end

  def organization_params
    p = params.require(:organization).permit(:name, :address, :search, admins_attributes: [:id, :username, :email, :password])
    return p
  end
end