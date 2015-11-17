class  User < ActiveRecord::Base

	include Concerns::User::Password
	include ActiveUUID::UUID
	# natural_key :id

	attr_accessor  :remember, :not_clear_reset_password_token

	# validates_uniqueness_of :email, :name, :phone

	# validates_confirmation_of :password #验证变量xxx和xxx_confirmation

	validates_presence_of :name, :if => :new_record?
	validates_presence_of :email


	validates :email,
	          format: { with: VALID_EMAIL_ADDRESS },
	          allow_nil: true,
	          allow_blank: true

	validates :password,
	          length: { minimum: 5 },
	          allow_nil: true

	validates :phone,
	          uniqueness: true, #{ scope: :site_id },
	          allow_nil: true

	validates :name,
	          uniqueness: true, #{ scope: :site_id },
	          allow_nil: true

	before_create :set_register_token

	def set_register_token
		self.register_token = SecureRandom.hex(24)
		self.register_token_sent_at = Time.now
	end

	def refresh_remember_token
		self.remember_token = SecureRandom.base64(32)
		save(:validate => false)
	end


	before_save :clear_reset_password_token, :unless => :not_clear_reset_password_token
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


end
