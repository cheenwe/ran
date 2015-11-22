class ApplicationMailer < ActionMailer::Base

  layout 'mailer'
  default from: Setting.admin_email
end
