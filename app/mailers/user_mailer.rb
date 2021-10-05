class UserMailer < ApplicationMailer
  default from: 'sidkhalidgpc@gmail.com'

  def send_credentials
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Your Credentials For SurveySpot")
  end

  def send_email_form
    @form = Form.find(params[:form_id])
    @link = new_form_form_submission_url(@form)
    @link << '?email='+params[:email]
    mail(to:params[:email], subject:"Fill This Survey")
  end
end
