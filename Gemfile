source 'https://rubygems.org'


gem 'rails', '~> 5.0.0'

gem 'puma', '~> 3.0'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

gem 'jquery-rails'
gem 'turbolinks', '~> 5'

gem 'angularjs-rails', '1.2.22'

# 用户系统
gem 'devise'



gem 'rails-settings-cached'
# gem "settingslogic"

gem 'rails-i18n'#, github: 'svenfuchs/rails-i18n', branch: 'master'
gem 'http_accept_language'

# 上传组件
gem 'carrierwave'
gem "carrierwave-qiniu"
gem 'qiniu-rs'
gem 'mini_magick'

# 搜索
gem "ransack"

# 分页
gem 'will_paginate'

# API
gem 'active_model_serializers'

# 权限
gem 'cancancan'
gem 'active_model_serializers-cancan'

# Redis
gem 'redis', '~> 3.0'


# 队列
gem 'sidekiq'

# Sidekiq Web
gem 'sinatra', git: 'https://github.com/sinatra/sinatra.git', require: false


# Mailer Service
gem 'postmark'
gem 'postmark-rails'

# Cache, kgio is for Dalli
gem 'kgio' #非阻塞I / O
gem 'dalli'


gem 'unicorn'

#使用云片网api发送短信
# gem 'smart_sms'

# API推送
gem 'jpush', :git => 'git://github.com/jpush/jpush-api-ruby-client.git'

# Web端推送
gem 'pusher'

# #  二维码
# gem 'rqrcode', '~> 0.10.1'

# 监控
gem 'newrelic_rpm'

group :development, :test do
  gem 'byebug'#, platform: :mri
  gem 'bundler-audit', require: false
  gem 'codecov', require: false

end

group :development do

  gem 'sqlite3'
  gem 'rubocop', require: false

  # JS CSS终端不显示
  # gem 'quiet_assets'

  # 显示 N+1
  gem 'bullet'


  gem 'better_errors'
  # 字段在model显示
  gem "annotate"

  # 服务器部署
  gem 'capistrano', '~> 3.1.0'
  gem 'capistrano-rails', '~> 1.1.0'
  gem 'capistrano-bundler'
  gem 'capistrano-sidekiq'
  gem 'capistrano-rbenv', "~> 2.0"

  gem 'web-console'
  gem 'listen', '~> 3.0.5'

  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

