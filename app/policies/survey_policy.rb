class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def new?
    user.present?
  end
  
  def update?
    return false if user.nil?
    record.user == user || user.is_admin
  end

  def destroy?
    return false if user.nil?
    record.user == user || user.is_admin
  end
end
