class  User < ActiveRecord::Base
	include ActiveUUID::UUID
	# natural_key :id


	attr_accessor :password_confirmation

	before_create :set_register_token


	def set_register_token
		self.register_token = SecureRandom.hex(24)
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

	def self.authenticate(name, password)
		return nil if name.blank? || password.blank?
		user = find_by_name(name) or return nil
		hash = Digest::SHA256.hexdigest(user.password_salt + password)
		hash == user.encrypted_password ? user : nil
	end



	def refresh_remember_token
	  self.remember_token = SecureRandom.base64(32)
	  save(:validate => false)
	end



end
