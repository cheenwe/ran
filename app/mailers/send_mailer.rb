class SendMailer < BaseMailer

  # SendMailer.register('chenwei@em-data.com.cn','123123').deliver_later
  def register(email, code)
    return false if email.blank?
    @mail ={
      email: email,
      code: code
    }
    mail(to: email, subject: "欢迎注册使用 #{Setting.app_name}" )
  end

end
