# coding: utf-8
class BaseUploader < CarrierWave::Uploader::Base
  storage :qiniu
  # storage :file

  # store dir
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end


  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  def filename
    if original_filename
      @name ||= Digest::MD5.hexdigest(current_path)
      "#{@name}.#{file.extension}"
    end
  end
end