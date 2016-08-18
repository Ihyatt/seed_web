class APIKeyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_admin
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def new?
    user.present?
  end
  
  def show?
    return false if user.nil?
    record.user == user || user.is_admin
  end

  def destroy?
    return false if user.nil?
    record.user == user || user.is_admin
  end
end
