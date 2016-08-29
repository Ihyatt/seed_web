class RacePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def show?
    return false if user.nil?
    user.is_admin
  end

  def create?
    return false if user.nil?
    user.is_admin
  end
  
  def update?
    return false if user.nil?
    user.is_admin
  end

  def destroy?
    return false if user.nil?
    user.is_admin
  end
end
