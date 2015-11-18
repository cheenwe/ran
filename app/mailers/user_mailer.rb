class UserMailer < ApplicationMailer
  def confirmation_email(user)
    @user = user
    mail(:to => user.email, subject: t('mail.register_email_subject', app_name: Setting.app_name) )
  end

  def password_reset_email(user)
    @user = user
    mail(:to => user.email,  subject: t('mail.password_reset', app_name: Setting.app_name) )
  end
end
