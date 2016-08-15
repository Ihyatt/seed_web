class APIKeyPolicy < ApplicationPolicy
  attr_reader :user, :api_key

  def initialize(user, api_key)
    @user = user
    @api_key = api_key
  end

  class Scope < Scope
    def resolve
      if user.is_admin
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def show?
    api_key.user == user || user.is_admin
  end

  def destroy?
    api_key.user == user || user.is_admin
  end
end
