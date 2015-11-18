if ENV['TRAVIS']
  source 'https://rubygems.org'
else
  source 'https://ruby.taobao.org'
end

gem 'rails', '4.2.4'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'



gem 'ransack'
gem 'sidekiq'
gem 'mysql2'
gem "activeuuid"
gem 'simple_form'

gem 'rails-i18n'
gem 'http_accept_language'
gem 'settingslogic' #自定义配置置
gem 'rucaptcha' #图片验证码
	# Ubuntu
	# sudo apt-get install imagemagick
	# Mac OS X
	# brew install imagemagick ghostscript

group :development, :test do

  gem "better_errors"
  gem "pry-rails"
  gem 'sqlite3'
  gem 'faker'
  #生成假数据，如姓名，地址和电话号码
end

group :doc do
  gem 'sdoc', '~> 0.4.0'
end

