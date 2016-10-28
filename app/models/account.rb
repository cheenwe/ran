class Account < ApplicationRecord
  self.table_name = 'users'

  include Concerns::Tablable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  table_attr :email, :sign_in_count, :created_at, :current_sign_in_at, :last_sign_in_ip

  def admin?
    self.id == 1 || self.id == 289
  end
end
