class  User < ActiveRecord::Base
  include ActiveUUID::UUID

  attr_accessor :password_confirmation


  before_create :set_register_token


  def set_register_token
    self.register_token = SecureRandom.hex(12)
    self.register_token_sent_at = Time.now
  end


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
