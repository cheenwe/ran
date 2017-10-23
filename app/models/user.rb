class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :omniauthable, :authentication_keys => [:login]
  attr_accessor :login

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value OR lower(phone) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end



  has_many :authorizations, dependent: :destroy #  one of [:destroy, :delete_all, :nullify, :restrict_with_error, :restrict_with_exception]


  def bind_service(response)
    provider = response['provider']
    uid = response['uid'].to_s
    authorizations.create(provider: provider, uid: uid)
  end

end
