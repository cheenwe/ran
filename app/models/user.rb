class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include OmniauthCallbacks

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable, :omniauthable


  enum state: { deleted: -1, normal: 1, blocked: 2 }

  has_many :authorizations, dependent: :destroy

  # 是否是管理员
  def admin?
    Istar.config.has_admin?(email)
  end

end
