class BaseMailer < ActionMailer::Base
  layout 'mailer'

  default from:     proc { default_sender_address.format }
  default reply_to: proc { default_reply_to_address.format }

  default charset: "utf-8"
  default content_type: "text/html"

  def self.default_url_options
    options = {:protocol => Setting.protocol}
    if Setting.host_name.to_s =~ /\A(https?\:\/\/)?(.+?)(\:(\d+))?(\/.+)?\z/i
      host, port, prefix = $2, $4, $5
      options.merge!({
        :host => host, :port => port, :script_name => prefix
      })
    else
      options[:host] = Setting.host_name
    end
    options
  end

  private


  def default_sender_address
    address = Mail::Address.new(Istar.config.mailer_sender)
    address.display_name = Istar.config.mailer_sender_display_name
    address
  end

  def default_reply_to_address
    address = Mail::Address.new(Istar.config.email_reply_to)
    address.display_name = Istar.config.email_display_name
    address
  end
end
