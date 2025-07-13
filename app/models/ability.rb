# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.admin?
      can :manage, :all
    elsif user.staff?
      can :read, User
    else
      can :read, :public
    end
  end
end
