class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
  end
  def new
    @organization = current_user.organizations.build
  end
  def create
    @organization = current_user.organizations.build(organization_params)
    @organization.save
    redirect_to user_organizations_path
  end
  def show
    @organization = Organization.find(params[:id])
  end
  def edit
    @organization = Organization.find(params[:id])
  end
  def update
    @organization = Organization.find(params[:id])
    @organization.update(organization_params)
    redirect_to user_organization_path(current_user, @organization)
  end
  def destroy
    @organization = Organization.find(params[:id])
    @organization.destroy
    redirect_to user_organizations_path(current_user)
  end

  def organization_params
    params.require(:organization).permit(:name)
  end
end