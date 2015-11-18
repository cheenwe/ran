require 'active_support/concern'

module Concerns
	module User
		module Password
			extend ActiveSupport::Concern

			included do
				attr_accessor :password, :password_confirmation, :not_clear_reset_password_token
				before_save :encrypt_password
				before_save :clear_reset_password_token, :unless => :not_clear_reset_password_token
			end

			def refresh_reset_password_token
				self.reset_password_token = SecureRandom.hex(24)
				self.reset_password_sent_at = Time.now
				self.not_clear_reset_password_token = true
				save(:validate => false)
			end

			def clear_reset_password_token
				self.reset_password_token = nil
				self.reset_password_sent_at = nil
			end

			def encrypt_password
				if password.present?
					self.password_salt = SecureRandom.base64(12)
					self.encrypted_password = legacy_password_hash(password_salt, password)
				end
			end

			def authenticate(name, password)
				return nil if name.blank? || password.blank?
				user = (self.class.find_by_name(name)  ||  self.class.find_by_email(name)  || self.class.find_by_phone(name) ) or return nil
				hash = legacy_password_hash(user.password_salt,password)
				hash == user.encrypted_password ? user : nil
			end

			def legacy_password_hash(salt,password)
				pass = Digest::MD5.hexdigest(password)
				2.times { pass = Digest::SHA1.hexdigest(pass.to_s + salt.to_s) }
				pass
			end

		end
	end
end
