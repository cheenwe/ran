ActionMailer::Base.delivery_method = Istar.config.email_delivery["delivery_method"]

if ActionMailer::Base.delivery_method == :smtp
    ActionMailer::Base.smtp_settings = {
      :address => Istar.config.email_delivery["smtp_settings"]["address"],
      :port => Istar.config.email_delivery["smtp_settings"]["port"],
      :domain => Istar.config.email_delivery["smtp_settings"]["domain"],
      :authentication => Istar.config.email_delivery["smtp_settings"]["authentication"],
      :user_name => Istar.config.email_delivery["smtp_settings"]["user_name"],
      :password => Istar.config.email_delivery["smtp_settings"]["password"]
    }
end