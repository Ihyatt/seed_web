class SurveyPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope
    end
  end

  def update?
    post.user == current_user || user.has_role?(:admin)
  end
end
