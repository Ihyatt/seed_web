class SurveySerializer < BaseSerializer
  attributes :id
  has_one :user
end
