class UserMailer < ApplicationMailer
  default from: 'sidkhalidgpc@gmail.com'

  def send_credentials
    @user = params[:user]
    @password = params[:password]
    mail(to: @user.email, subject: "Your credentials")
  end

end
