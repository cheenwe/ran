# encoding: utf-8
require 'carrierwave/processing/mini_magick'
IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(normal mini small large big)

class AvaterUploader < BaseUploader
  include CarrierWave::MiniMagick

  # storage :file
  # storage :fog
  storage :qiniu

  # 覆盖 url 方法以适应“图片空间”的缩略图命名
  def url(version_name = "")
    @url ||= super({})
    version_name = version_name.to_s
    return @url if version_name.blank?
    if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
      # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
      raise "AvatarUploader version_name:#{version_name} not allow."
    end
    [@url,version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # def filename
  #   if super.present?
  #     model.uploader_secure_token ||= SecureRandom.uuid.gsub("-","")
  #     Rails.logger.debug("(BaseUploader.filename) #{model.uploader_secure_token}")
  #     "#{model.uploader_secure_token}.#{file.extension.downcase}"
  #   end
  # end

  # Create different versions of your uploaded files:

  version :normal do
  end

  version :mini do
    process resize_to_fill: [16,16]
  end

  version :small do
    process resize_to_fill: [48,48]
  end

  version :large do
    process resize_to_fill: [96,96]
  end

  version :big do
    process resize_to_fill: [120, 120]
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

end
