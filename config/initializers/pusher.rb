require 'pusher'

Pusher.app_id = Setting.pusher_app_id
Pusher.key = Setting.pusher_key
Pusher.secret = Setting.pusher_secret

Pusher.logger = Rails.logger
Pusher.encrypted = true
