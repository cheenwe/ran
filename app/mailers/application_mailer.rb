class ApplicationMailer < ActionMailer::Base

  layout 'mailer'
  default from: Setting.admin_email #这里改为您的配置的发件邮箱
end
