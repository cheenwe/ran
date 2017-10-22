
# gems

## 配置  - yes
gem "rails-settings-cached"

Generate your settings:

> rails g settings:install

If you want custom model name:

> rails g settings:install SiteConfig

## PG性能监测 - yes

https://github.com/ankane/pghero/blob/master/guides/Rails.md



## 异常捕捉 - no

https://github.com/rails-engine/exception-track

[说明](https://ruby-china.org/topics/32325)

gem 'exception-track'

>rails g exception_track:install