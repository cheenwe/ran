class  User < ActiveRecord::Base

	include Concerns::User::Password
	include ActiveUUID::UUID
	# natural_key :id

	attr_accessor  :remember, :captcha

	# validates_confirmation_of :password #验证变量xxx和xxx_confirmation

	validates_presence_of :name, :if => :new_record?
	validates_presence_of :email

	validates_length_of :password, :in => 6..30, :allow_blank => true

	validates_presence_of :name, :unless => :new_record?
	validates_presence_of :email
	validates_uniqueness_of :name, :unless => :new_record? && :name_is_blank?
	validates_uniqueness_of :email
	validates_format_of :email, :with => VALID_EMAIL_ADDRESS
	validates_uniqueness_of :phone, :allow_blank => true




  default_scope { order('created_at DESC') }
	scope :verified, -> { where(verified: true) }

	before_create :set_register_token

	def set_register_token
		self.register_token = SecureRandom.hex(24)
		self.register_token_sent_at = Time.now
	end

	def refresh_remember_token
		self.remember_token = SecureRandom.base64(32)
		save(:validate => false)
	end

	def name_is_blank?
		self.name.blank?
	end

	def can_login_in?
		verified?
	end

	def update_tracked_fields(request)
		self.sign_in_count ||= 0
		self.sign_in_count += 1
		self.save
	end
end
