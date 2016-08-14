class APIKeySerializer < ActiveModel::Serializer
  attributes :read_key, :write_key
end
