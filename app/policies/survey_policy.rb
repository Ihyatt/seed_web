class SurveyPolicy < ApplicationPolicy
  attr_reader :user, :survey

  def initialize(user, survey)
    @user = user
    @survey = survey
  end

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
    survey.user == user || user.is_admin
  end

  def destroy?
    return false if user.nil?
    survey.user == user || user.is_admin
  end
end
