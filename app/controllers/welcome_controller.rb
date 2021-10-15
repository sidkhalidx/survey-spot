class WelcomeController < ApplicationController
  def index
    redirect_to new_user_session_path unless user_signed_in?
    if user_signed_in?
      redirect_to user_organizations_path(current_user) if current_user.super_admin?
      redirect_to forms_path if ( current_user.admin? || current_user.manager?)
    end
  end
end
