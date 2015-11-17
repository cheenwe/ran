class UserMailer < ApplicationMailer
  def signup_email(user)
    @user = user
    mail(:to => user.email, :subject => t(:signup_email_subject))
  end

  def password_reset_email(user)
    @user = user
    mail(:to => user.email,  subject: "#{t('mail.password_reset', app_name: Setting.app_name)}")
  end
end
