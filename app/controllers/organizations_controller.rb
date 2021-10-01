class OrganizationsController < ApplicationController
  def index
    @organizations = Organization.all
    authorize @organizations
  end
  def new
    @organization = current_user.organizations.build
    authorize @organization
  end
  def create
    @organization = current_user.organizations.build(organization_params)
    @organization.admins[0].role="admin"
    @password = @organization.admins[0].password
    if @organization.save
      UserMailer.with(user: @organization.admins[0], password: @password).send_credentials.deliver_later
    else
      render 'new'
    end
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
    p = params.require(:organization).permit(:name, admins_attributes: [:id, :username, :email, :password])
    return p
  end
end