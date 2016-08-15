class QuestionSerializer < ActiveModel::Serializer
  attributes :id, :title
  has_one :survey
end
