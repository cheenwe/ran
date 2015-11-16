class UserMailer < ApplicationMailer

  def password_reset_email(user)
    @user = user
    mail(:to => user.email, :subject => t(:reset_password_email_subject))
  end
end
