require 'pusher'

Pusher.app_id = Settings.pusher_app_id
Pusher.key = Settings.pusher_key
Pusher.secret = Settings.pusher_secret

Pusher.logger = Rails.logger
Pusher.encrypted = true
