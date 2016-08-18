class ConversationPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.is_admin
        scope.all
      else
        scope.where(customer: user)
      end
    end
  end

  def new?
    user.present?
  end

  def show?
    return false if user.nil?
    record.customer == user || user.is_admin
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
