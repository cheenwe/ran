class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, :lockable, :timeoutable


  enum state: { deleted: -1, normal: 1, blocked: 2 }


  # 是否是管理员
  def admin?
    Istar.config.has_admin?(email)
  end

end
