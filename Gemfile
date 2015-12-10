# if ENV['TRAVIS']
#   source 'https://rubygems.org'
# else
#   source 'https://ruby.taobao.org'
# end
source 'https://rubygems.org'

gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'

gem 'ransack'
gem 'will_paginate'
gem 'sidekiq'
gem 'mysql2'
gem "activeuuid"
gem 'simple_form'

gem 'rails-i18n', github: 'svenfuchs/rails-i18n', branch: 'master'
gem 'http_accept_language'
gem 'settingslogic' #自定义配置置
gem 'rucaptcha' #图片验证码
	# Ubuntu
	# sudo apt-get install imagemagick
	# Mac OS X
	# brew install imagemagick ghostscript
gem 'qingting_api', github: 'cheenwe/qingting_api'
group :development, :test do

  # gem "better_errors"
  gem "pry-rails"
  gem 'sqlite3'
  # gem 'faker'
  #生成假数据，如姓名，地址和电话号码

  gem 'cucumber-rails', :require => false
  # database_cleaner is not required, but highly recommended
  gem 'database_cleaner'
  # gem 'simplecov', :require => false #代码覆盖率测试
  # gem 'spork', '~> 1.0rc'
  # gem 'capybara'
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

