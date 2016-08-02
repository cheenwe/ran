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
  else
    config.storage = :qiniu
  end
  # Do not remove previously file after new file uploaded
  config.qiniu_access_key = Settings.qiniu_access_key
  config.qiniu_secret_key = Settings.qiniu_secret_key
  config.qiniu_bucket = Settings.qiniu_bucket
  config.qiniu_bucket_domain = Settings.qiniu_bucket_domain
  config.qiniu_block_size = Settings.qiniu_block_size
  config.qiniu_protocal = Settings.qiniu_protocal

end