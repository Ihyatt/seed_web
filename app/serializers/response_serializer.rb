class ResponseSerializer < BaseSerializer
  attributes :id, :kind
  has_one :question
end
