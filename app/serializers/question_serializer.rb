class QuestionSerializer < BaseSerializer
  attributes :id, :title
  has_one :survey
end
