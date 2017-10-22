
redis_config = Rails.application.config_for(:redis)

$redis = Redis::Namespace.new("site_point", :redis => Redis.new)

# $redis.set("aa", "Hello World!")
# $redis.get("aa")
