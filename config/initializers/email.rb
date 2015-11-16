begin
  settings = YAML::load_file(File.dirname(__FILE__) + '/../email.yml')[Rails.env]['smtp']
rescue
  puts "==============error=============="
  puts "===please config your email ========"
  puts "===cp email.yml.example email.yml=="
  puts "================================"
else
  settings.symbolize_keys!
  settings[:authentication] = settings[:authentication].to_sym if settings[:authentication]
  ActionMailer::Base.smtp_settings = settings rescue nil
end

unless defined? VALID_EMAIL_ADDRESS
  VALID_EMAIL_ADDRESS = /\A[a-z\-_0-9\.%]+(\+[a-z\-_0-9\.%]+)?\@[a-z\-0-9\.]+\.[a-z\-]{2,}\z/i
end
