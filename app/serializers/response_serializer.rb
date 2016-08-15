class ResponseSerializer < ActiveModel::Serializer
  attributes :id, :kind
  has_one :question
end
