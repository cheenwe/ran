#encoding: UTF-8
class Ability
  include CanCan::Ability
  def initialize(user)

    unless user.blank?
      if user.admin?
        can :manage, :all
      else

      end
    end
  end
end
