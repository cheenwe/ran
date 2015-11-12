class  User < ActiveRecord::Base

  include ActiveUUID::UUID


  attr_accessor :password_confirmation

  def password
    @password
  end

  def password=(new_password)
    @password = new_password

    unless @password.blank?
      self.password_salt = SecureRandom.base64(12)
      self.encrypted_password = Digest::SHA256.hexdigest(password_salt + password)
    end
  end



end
