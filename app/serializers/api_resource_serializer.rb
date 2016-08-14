class APIResourceSerializer < ActiveModel::Serializer
  attributes :status, :data, :pagination
end
