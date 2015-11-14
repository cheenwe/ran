class  User < ActiveRecord::Base

  include Concerns::User::Password
	include ActiveUUID::UUID
	# natural_key :id


	attr_accessor :password_confirmation

	before_create :set_register_token


	def set_register_token
		self.register_token = SecureRandom.hex(24)
		self.register_token_sent_at = Time.now
	end

	def refresh_remember_token
	  self.remember_token = SecureRandom.base64(32)
	  save(:validate => false)
	end

end
