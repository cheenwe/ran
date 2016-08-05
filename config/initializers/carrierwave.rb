require 'carrierwave'
require 'carrierwave/validations/active_model'

CarrierWave::SanitizedFile.sanitize_regexp = /[^[:word:]\.\-\+]/

class NullStorage
  attr_reader :uploader

  def initialize(uploader)
    @uploader = uploader
  end

  def identifier
    uploader.filename
  end

  def store!(_file)
    true
  end

  def retrieve!(_identifier)
    true
  end
end


CarrierWave.configure do |config|
  if Rails.env.test?
    config.storage NullStorage
  elsif Settings.choice_storage == "qiniu"
    config.storage = :qiniu
    # Do not remove previously file after new file uploaded
    config.qiniu_access_key = Settings.qiniu_access_key
    config.qiniu_secret_key = Settings.qiniu_secret_key
    config.qiniu_bucket = Settings.qiniu_bucket
    config.qiniu_bucket_domain = Settings.qiniu_bucket_domain
    config.qiniu_block_size = Settings.qiniu_block_size
    config.qiniu_protocal = Settings.qiniu_protocal

  elsif Settings.choice_storage == "upyun"
    # gem 'carrierwave-upyun'

    config.storage = :upyun
    config.upyun_username = Settings.upyun_username
    config.upyun_password = Settings.upyun_password
  elsif Settings.choice_storage == "aliyun"
    # gem 'carrierwave-aliyun'

    config.storage           = :aliyun
    config.aliyun_access_id  = Settings.aliyun_access_id
    config.aliyun_access_key = Settings.aliyun_access_key
    # 你需要在 Aliyum OSS 上面提前创建一个 Bucket
    config.aliyun_bucket     = Settings.aliyun_bucket
    # 是否使用内部连接，true - 使用 Aliyun 局域网的方式访问  false - 外部网络访问
    config.aliyun_internal   = false
    # 配置存储的地区数据中心，默认: cn-hangzhou
    config.aliyun_area       = Settings.aliyun_area
    # 使用自定义域名，设定此项，carrierwave 返回的 URL 将会用自定义域名
    # 自定于域名请 CNAME 到 you_bucket_name.oss.aliyuncs.com (you_bucket_name 是你的 bucket 的名称)
    config.aliyun_host       = Settings.aliyun_host
  end
end
